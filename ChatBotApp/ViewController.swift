//
//  ViewController.swift
//  ChatBotApp
//
//  Created by 김은지 on 2023/06/08.
//


import UIKit




class ViewController: UIViewController {
    
   
    @IBOutlet weak var myTableView: UITableView!
    



    

    @IBOutlet weak var sendBtn: UIButton!

    
    
    var messages: [ResponseMessage] = []
    
    @IBOutlet weak var chatTextView: UITextView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        myTableView.dataSource = self
       
        
            print(#fileID, #function, #line, "- data \(messages)")
        
        myTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        chatTextView.textContainer.maximumNumberOfLines = 5
        chatTextView.textContainer.lineBreakMode = .byTruncatingHead
    
        
      
 
    
       
    
        
    }
    

         

    @IBAction func sendBtnClicked(_ sender: UIButton) {
            print(#fileID, #function, #line, "- <# 주석 #>")
        
        
      
        sender.setTitle("로딩중", for: .normal)
        sender.setTitleColor(.black, for: .normal)
        sender.titleLabel?.font = .systemFont(ofSize: 15)
        
        
        callPostMethod(chatTextView.text) {
          
            DispatchQueue.main.async {
                sender.setTitle("", for: .normal)
               
                self.sendBtn.setImage(UIImage(named: "paperplane"),
                                      
                                       for: .normal)
                self.myTableView.reloadData()
                self.chatTextView.text = ""
            }
           
        }
        
        
    }
    
 
    
    
    
    
    fileprivate func callPostMethod(_ myText: String?, _ completion: @escaping () -> Void){
        print(#fileID, #function, #line, "-   ")
        
        let urlString: String = "https://wsapi.simsimi.com/190410/talk"
        
            print(#fileID, #function, #line, "- urlString\(urlString)")
        
        guard let url = URL(string: urlString) else { return }
        
        print(#fileID, #function, #line, "- url\(url)")
        
        var utext: String = ""
        
        
        // 타이틀 옵셔널 벗기기
        if myText != nil || !(myText?.isEmpty ?? true) {
            utext = myText ?? ""
        }
        
        // JSON 데이터
        let preJsonData: [String: Any] = [
            
            "utext" : "\(String(describing: utext))",
            "lang" : "ko"
            
        ]
        
        
        
        // JSON 데이터로 직렬화하는 기능 - JSONSerialization
        let jsonData = try? JSONSerialization.data(withJSONObject: preJsonData)
        
        // HTTP 요청
        var urlReuqest = URLRequest(url: url)
        urlReuqest.httpMethod = "POST"
        urlReuqest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReuqest.setValue("rUuD~h5BovqUCvBZnVla69kdG~eqirQ-VpLvqmmS", forHTTPHeaderField: "x-api-key")
     
  
        urlReuqest.httpBody = jsonData
        
        
        // 요청 보내기 - URLSession
        let task = URLSession.shared.dataTask(with: urlReuqest) { data, response, error in
            
            if let error = error {
                print(#fileID, #function, #line, "- 할일 목록 수정 실패 \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                let httpResponse = response as? HTTPURLResponse
                
                    print(#fileID, #function, #line, "- 할일 목록 수정 실패(응답코드: \(httpResponse?.statusCode)")
                return
            }
            
            print(#fileID, #function, #line, "- 할 일 목록 수정 성공(응답)")
            guard let data = data else { return     print(#fileID, #function, #line, "- 데이터 없음") }
            
            do {
                
                let messageResponse: ResponseMessage = try JSONDecoder().decode(ResponseMessage.self, from: data)
                    print(#fileID, #function, #line, "- messageResponse \(messageResponse)")
                
                self.messages.append(messageResponse)
                
                print(#fileID, #function, #line, "-  message \(self.messages)")
                
                completion()
                

            } catch {
                print(#fileID, #function, #line, "- \(error)")
            }
        }
        
        task.resume()
        
        
    }
    
    
    
    
    
    
    
    
    
    
}

extension ViewController: UITableViewDataSource {
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#fileID, #function, #line, "- messages.count\(messages.count)")
        
        return messages.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row / 2]
        
        // 짝수 행 내가 보낸 채팅
        if indexPath.row % 2 == 0 {
            print(#fileID, #function, #line, "-  주석")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatCell", for: indexPath) as? MyChatCell else { return UITableViewCell() }
            
            
            
            cell.myTextView.text = message.request.utext
            
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell.myTextView.clipsToBounds = true
            cell.myTextView.layer.cornerRadius = 7
            return cell
            
            
        } else {
            print(#fileID, #function, #line, "-  주석")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell else { return UITableViewCell() }
            
            
            
            cell.chatTextView.text = message.atext
            
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell.chatTextView.clipsToBounds = true
            cell.chatTextView.layer.cornerRadius = 7
            
            
            return cell
        }
        
    }
    
    
}


