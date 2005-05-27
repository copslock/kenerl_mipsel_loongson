Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 18:00:18 +0100 (BST)
Received: from server256.com ([IPv6:::ffff:202.85.141.143]:64948 "HELO
	server256.com") by linux-mips.org with SMTP id <S8226075AbVE0RAD>;
	Fri, 27 May 2005 18:00:03 +0100
Received: (qmail 16408 invoked by uid 512); 27 May 2005 16:59:49 -0000
Message-ID: <20050527165949.17623.qmail@server256.com>
Reply-To: "Cameron Cooper" <developer@phatlinux.com>
From:	"Cameron Cooper" <developer@phatlinux.com>
To:	"Alan Cox" <alan@lxorguk.ukuu.org.uk>,
	"Cameron Cooper" <developer@phatlinux.com>,
	linux-mips@linux-mips.org
Subject: Re: Porting To New System
Date:	Fri, 27 May 2005 16:59:49 +0000
MIME-Version: 1.0
X-Mailer: WebMail 2.0
X-Originating-IP: 128.146.88.154
X-Originating-Email: developer@phatlinux.com
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-Path: <developer@phatlinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: developer@phatlinux.com
Precedence: bulk
X-list: linux-mips

>  > So even if this is a bad way of doing it, is it even possable?
>  
>  It's certainly a good way to get started. Several ports began by using
>  boot firmware drivers and then eventually replaced them.
>  
>  Does the firmware give you the ability to control MMU mappings ?

At this time only a few firmware functions are known. Well, to be more exact, only a few are usable. While we know many of the functions provided by the firmware, we do not know many of thier arguments. At this time we know how to maniuplate the frame buffer, read button presses, read/write to the memory stick, and play back audio, but we do not have a way to control MMU mappings. We have only had the ability to write/execute code on the PSP for a month. Discoveries are being made all the time, so we will certainly know more about the firmware in the coming weeks.
