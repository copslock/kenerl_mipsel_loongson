Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Oct 2002 13:44:44 +0200 (CEST)
Received: from webmail22.rediffmail.com ([203.199.83.144]:35983 "HELO
	webmail22.rediffmail.com") by linux-mips.org with SMTP
	id <S1123916AbSJVLon>; Tue, 22 Oct 2002 13:44:43 +0200
Received: (qmail 26270 invoked by uid 510); 22 Oct 2002 11:45:57 -0000
Date: 22 Oct 2002 11:45:57 -0000
Message-ID: <20021022114557.26269.qmail@webmail22.rediffmail.com>
Received: from unknown (203.200.7.244) by rediffmail.com via HTTP; 22 Oct 2002 11:45:57 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: {swapper:1] illegal instruction at ... 
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,
I have just now enabled the nfs mount of root file system.
after this when I boot i get so many repeated messages like..

[swapper:1] Illegal instruction d0c62bd0 at 800f7c6c ra=
800f4860
[swapper:1] Illegal instruction 0031c78 at 800f5b5c at 
ra=8002d954
......
and similar many illegal instructions at different addresses.

in System.map if i watch for these adreses they are mostly from 
routines in linux/net/* and linux/net/ipv4/* directories.

what are the chances for it be compiler problem.

version of mips-linux-gcc complier that i get from
"mips-linux-gcc -v" is
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

can somebody suggest me something..

Best Regards,
Atul



__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
