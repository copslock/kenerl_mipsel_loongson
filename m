Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QHYNJ29805
	for linux-mips-outgoing; Fri, 26 Oct 2001 10:34:23 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QHYJ029802
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 10:34:20 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id UAA00972;
	Fri, 26 Oct 2001 20:34:08 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id VAA00854; Fri, 26 Oct 2001 21:23:29 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id UAA09739; Fri, 26 Oct 2001 20:29:08 +0300 (MSK)
Message-ID: <3BD99DAC.EB762713@niisi.msk.ru>
Date: Fri, 26 Oct 2001 21:30:20 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Backspace on Virtual Console causes oops
References: <20011026161259.54925.qmail@web11908.mail.yahoo.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:
> 
> Dear All,
> 
> I am having a problem with the backspace key on a
> virtual terminal on a 2.4.2 kernel. If I hit backspace
> when there is input at the command line - no problem
> it deletes the character before the cursor.
> But if I press backspace when there are no characters
> at the command prompt, the kernel throws an oops. The
> process causing the oops is Bash.
> Note, on the Serial console, backspace works fine all
> the time.
> 
> Has anyone ever seen anything like this ? If you have
> how did you solve it ?
> 

Guess 1: You've got PC UARTs and drivers/char/serial.c
Guess 2: TAB TAB in bash causes the oops too.
Guess 3: You didn't change famous beep function in the driver.


Regards,
Gleb.
