Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 04:13:17 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:8576
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8224954AbUERDNQ>; Tue, 18 May 2004 04:13:16 +0100
Received: (qmail 9193 invoked by uid 204); 18 May 2004 13:13:05 +1000
Received: from stuartl@longlandclan.hopto.org by www by uid 201 with qmail-scanner-1.16 
 (spamassassin: 2.63.  Clear:. 
 Processed in 0.034629 secs); 18 May 2004 03:13:05 -0000
Received: from unknown (HELO longlandclan.hopto.org) (10.0.0.251)
  by 192.168.5.1 with SMTP; 18 May 2004 13:13:05 +1000
Message-ID: <40A97F41.3030605@longlandclan.hopto.org>
Date: Tue, 18 May 2004 13:13:05 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ratin@koperasw.com
CC: linux-mips@linux-mips.org
Subject: Re: setup X11 on MIPS64/MALTA
References: <005401c43c6b$35b750f0$6901a8c0@ratwin1>
In-Reply-To: <005401c43c6b$35b750f0$6901a8c0@ratwin1>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

Ratin Kumar wrote:

> I am trying to get X11 up on my MALTA (MIPS 64, little endian board). I 
> have the frame buffer working (using Matrox Mill – II PCI card). I also 
> have the Red Hat 7.3 installation going but I am not able to get X to 
> work. Has any one tried this combination OR if there is any advice on 
> this ??

How have you tried configuring XFree86?  Did you use the matrox driver 
or fbdev?  If the framebuffer works, then I'd suggest trying fbdev.

Beyond that, I wouldn't have a clue.
-- 
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Atomic Linux Project    <--->    http://atomicl.berlios.de/ |
+-------------------------------------------------------------+
