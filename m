Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:54:44 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.191]:11176 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035446AbXJNTyF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:54:05 +0100
Received: by mu-out-0910.google.com with SMTP id w1so1277293mue
        for <linux-mips@linux-mips.org>; Sun, 14 Oct 2007 12:53:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=z/Z0A2GUlW/vdqNl/9rxSlbCFV5rtsAaFPHhUSQXW0o=;
        b=nf8pxf8QGJfnpDHF1E8Hxii7qfK2qtWcbPwlvDmaLUhYiE5XSJrwC3dQkaDbijX/0FqQWyJL0wQ9YiWJIIknu6EvB5/y50B8HDqJumpm3SLcX7LEEoCOb0BXStrbJQx4t7wFhVpKmXZQ75yIS6As2/iL08BzAr9TlGlg+INZ1OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BopG9GNQUhsAr+8a1M/Sz/u1mUIqWslRbXMlEoecqi4bpn4qRzsl28kvT+h2u0X+6YTD3AdiW/KlrTQNjmVnzw4v0hM3Y5e4lvxvWRPklYY5CQ+RPtYzWnGe+WzoBxhPMUGgvacvdMXAII4PSmWHhgmOVzFSfwUk8jLSofvcrAw=
Received: by 10.86.76.16 with SMTP id y16mr4345119fga.1192391635284;
        Sun, 14 Oct 2007 12:53:55 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 13sm6432488fks.2007.10.14.12.53.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 12:53:54 -0700 (PDT)
Message-ID: <471273A6.5060709@gmail.com>
Date:	Sun, 14 Oct 2007 21:53:10 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
References: <470DF25E.60009@gmail.com> <20071011152615.GE3379@networkno.de>
In-Reply-To: <20071011152615.GE3379@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Franck Bui-Huu wrote:
> [snip]
>> Also not that with the current patchset applied, there are now 2
>> segments that need to be loaded, hopefully it won't cause any issues
>> with any bootloaders out there that would assume that an image has
>> only one segment...
> 
> This breaks at least conversion to ECOFF as used on DECstations.
> Srec might also be affected, I'm not sure about that.
> 

Ok, so I will reorder the things to have only one segment.

Thanks.
		Franck
