Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 10:25:12 +0100 (BST)
Received: from web94305.mail.in2.yahoo.com ([203.104.16.215]:17575 "HELO
	web94305.mail.in2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022218AbXG3JZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 10:25:07 +0100
Received: (qmail 6577 invoked by uid 60001); 30 Jul 2007 09:24:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Qu7/lh+xRShRDOFD4qTJC8XzPMJBB5CsGxCjXMta+EohS/P5dzZ2RLAIHTVJHX1P6U9pcHQ1N0wxCDqQAGyBHsJuqBoihPzthQtrJQunNm3KZdQ9a75Qupg01oSpX9649EZyUEAZgfZOEdUMevRaMn12sbEK6CgYJb1qqqZhLDk=;
X-YMail-OSG: eR61BysVM1nBhZHM6CBJfwwaFrOgrxyIqb8GyZ.X0fBdIPL8TD5c_quEguYLEDQNDurRXuzO.s2.wZ.7Y5hpmniriTE4y577hDrvZ21MHb5D8OnBE68-
Received: from [59.92.60.65] by web94305.mail.in2.yahoo.com via HTTP; Mon, 30 Jul 2007 10:24:59 BST
Date:	Mon, 30 Jul 2007 10:24:59 +0100 (BST)
From:	saravanan <sar_van81@yahoo.co.in>
Subject: desktop environments in MIPS
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-492768566-1185787499=:5687"
Content-Transfer-Encoding: 8bit
Message-ID: <518356.5687.qm@web94305.mail.in2.yahoo.com>
Return-Path: <sar_van81@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sar_van81@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-492768566-1185787499=:5687
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,
 
 has anyone ported any desktop environments in MIPS like Qtopia or OPIE ? if so can anyone send me the documents about that ?
 
 i had compiled OPIE but when i execute it on the board, i get segementaion fault error. if i execute the applications individually like:
 
 ./textedit -qws
  or
  $./datebook -qws
  
 the applications execute perfectly without any error message. but when i enter qpe as follows:
  $./qpe &.
  
 i get the following segemntation fault error.
 
 /mnt/image/bin # ./qpe -qws
 Doing slow search for ./qpe devicebuttons/z_calendar
 Doing slow search for ./qpe devicebuttons/z_contact
 Doing slow search for ./qpe devicebuttons/z_home
 Doing slow search for ./qpe devicebuttons/z_menu
 Doing slow search for ./qpe devicebuttons/z_mail
 Doing slow search for ./qpe launcher/firstuse
 : WARNING: XXXXXXXXXXX rescan
 Doing slow search for ./qpe logo/opielogo
 : WARNING: preferred keyboard is Pickboard
 Doing slow search for ./qpe BigBusy
 : WARNING: Found Applet: libaboutapplet.so
 : WARNING: Found Applet: libclipboardapplet.so
 : WARNING: Found Applet: libclockapplet.so
 Doing slow search for ./qpe launcher/opie-background
 Segmentation fault.
 
 
 can anyone provide me any suggesstions or solutions for this ?
 
 thanks in advance,
 
 saravanan
 
 
 
       
---------------------------------
 Why delete messages? Unlimited storage is just a click away.
--0-492768566-1185787499=:5687
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,<br> <br> has anyone ported any desktop environments in MIPS like Qtopia or OPIE ? if so can anyone send me the documents about that ?<br> <br> i had compiled OPIE but when i execute it on the board, i get segementaion fault error. if i execute the applications individually like:<br> <br> ./textedit -qws<br>  or<br>  $./datebook -qws<br>  <br> the applications execute perfectly without any error message. but when i enter qpe as follows:<br>  $./qpe &amp;.<br>  <br> i get the following segemntation fault error.<br> <br> /mnt/image/bin # ./qpe -qws<br> Doing slow search for ./qpe devicebuttons/z_calendar<br> Doing slow search for ./qpe devicebuttons/z_contact<br> Doing slow search for ./qpe devicebuttons/z_home<br> Doing slow search for ./qpe devicebuttons/z_menu<br> Doing slow search for ./qpe devicebuttons/z_mail<br> Doing slow search for ./qpe launcher/firstuse<br> : WARNING: XXXXXXXXXXX rescan<br> Doing slow search for ./qpe logo/opielogo<br> : WARNING: preferred
 keyboard is Pickboard<br> Doing slow search for ./qpe BigBusy<br> : WARNING: Found Applet: libaboutapplet.so<br> : WARNING: Found Applet: libclipboardapplet.so<br> : WARNING: Found Applet: libclockapplet.so<br> Doing slow search for ./qpe launcher/opie-background<br> Segmentation fault.<br> <br> <br> can anyone provide me any suggesstions or solutions for this ?<br> <br> thanks in advance,<br> <br> saravanan<br> <br> <br> <p>&#32;



      <!--1--><hr size=1></hr> Why delete messages? Unlimited storage is <a href="http://in.rd.yahoo.com/tagline_mail_1/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">just a click away.</a>
--0-492768566-1185787499=:5687--
