Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f55Monb17166
	for linux-mips-outgoing; Tue, 5 Jun 2001 15:50:49 -0700
Received: from mailhost.taec.toshiba.com (mailhost.taec.com [209.243.128.33])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f55MoRh17114;
	Tue, 5 Jun 2001 15:50:27 -0700
Received: from hdqmta.taec.toshiba.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id PAA07569;
	Tue, 5 Jun 2001 15:50:14 -0700 (PDT)
Subject: Re: Newbie Question, Please help
To: "Robert Rusek" <robru@teknuts.com>
Cc: linux-mips@oss.sgi.com, owner-linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF2C864542.A06C941E-ON88256A62.007A7DFC@taec.toshiba.com>
From: Adrian.Hulse@taec.toshiba.com
Date: Tue, 5 Jun 2001 15:24:11 -0700
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.5 |September 22, 2000) at
 06/05/2001 03:49:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Robert,

Maybe you've already tried this but.

Do you know for sure that tftp works on your RedHat 7.0 box OK ? Can you
use tftp to get files from directory /tftpboot ?

When I installed RedHat 7.0 and tried to use tftp it wouldn't work. I think
it comes with a rpm that is tftp-0.17-??.i386.rpm or something like that.
To check your version type :

rpm -q tftp

According to bugzilla at the time you have to back install to
tftp-0.16-5.i386.rpm. After doing this you will be able to use tftp.





                                                                                                                        
                    "Robert Rusek"                                                                                      
                    <robru@teknuts.com        To:     <linux-mips@oss.sgi.com>                                          
                    >                         cc:                                                                       
                    Sent by:                  Subject:     Newbie Question, Please help                                 
                    owner-linux-mips@o                                                                                  
                    ss.sgi.com                                                                                          
                                                                                                                        
                                                                                                                        
                    06/05/01 03:08 PM                                                                                   
                                                                                                                        
                                                                                                                        




the setup to run.  I am using the latest version of DHCP/BOOTP (ics 2.0) to
try to boot.  It gets the address then claims it is sending the vmlinux
file via tftp.  On the SGI it just times out.

Any advice, pointers, etc would be greatly appreciated.

Thanks in advance,
Robert Ruserk
