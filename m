Received:  by oss.sgi.com id <S554267AbRASUge>;
	Fri, 19 Jan 2001 12:36:34 -0800
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:32611 "EHLO
        iris1.csv.ica.uni-stuttgart.de") by oss.sgi.com with ESMTP
	id <S553721AbRASUgH>; Fri, 19 Jan 2001 12:36:07 -0800
Received: from rembrandt (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with SMTP id VAA422530
	for <linux-mips@oss.sgi.com>; Fri, 19 Jan 2001 21:36:04 +0100 (MET)
Message-ID: <002001c08257$7186d000$2a764581@rembrandt.csv.ica.uni-stuttgart.de>
From:   "Thiemo Seufer" <seufer@csv.ica.uni-stuttgart.de>
To:     <linux-mips@oss.sgi.com>
Subject: Re: Current CVS (010116) Boots OK
Date:   Fri, 19 Jan 2001 21:36:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Maciej W. Rozycki wrote:
[snip]
> It's possible.  I'm actually using `cu' and it works fine wrt wrapping
>but it requires hw flow control (it sets "-clocal" and "crtscts" 
>explicitly) unfortunately, which is why it cannot be used for the
>DECstation's REX console I/O (which uses DTR/DSR flow control due to
>serial interface limitations on certain DEC hardware).  I'm going to
>modify `cu' at one time but since I don't really work with REX that much
>I'm just using `cat' for this purpose for now.

You might try 'screen'. I don't know if it requires Hardware
flow control, but it works for me via

screen screen /dev/ttyS1


Thiemo
