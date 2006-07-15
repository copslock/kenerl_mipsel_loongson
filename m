Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jul 2006 14:07:48 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:57052 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S8133509AbWGONHj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Jul 2006 14:07:39 +0100
Received: by py-out-1112.google.com with SMTP id m51so940109pye
        for <linux-mips@linux-mips.org>; Sat, 15 Jul 2006 06:07:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bepYrY1NoYFxXi9CIN8gB0XMfGpxooDCjWgqoHvhamM1/bVSGQphLLyj35HrngqF3Q9KValMLlxy+LEGlOXez7pc0i6d3rBL6iwtBm5H4ZQsJWxbTT4QBPpznpxVJ6NO7pqfDPuAyNwVuYiPG6HQlM362KIIk+nvMU5k9LnFi0Q=
Received: by 10.35.19.6 with SMTP id w6mr922440pyi;
        Sat, 15 Jul 2006 06:07:37 -0700 (PDT)
Received: from ?192.168.232.98? ( [203.84.188.10])
        by mx.gmail.com with ESMTP id m68sm251473pye.2006.07.15.06.07.35;
        Sat, 15 Jul 2006 06:07:37 -0700 (PDT)
Message-ID: <44B8E88C.7050804@gmail.com>
Date:	Sat, 15 Jul 2006 21:07:24 +0800
From:	"Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To:	linux-fbdev-devel@lists.sourceforge.net
CC:	linux-mips@linux-mips.org, Rodolfo Giometti <giometti@linux.it>
Subject: Re: [Linux-fbdev-devel] [PATCH] au1100fb.c cursor enable/disable
References: <20060712064519.GA17240@gundam.enneenne.com>
In-Reply-To: <20060712064519.GA17240@gundam.enneenne.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <adaplas@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adaplas@gmail.com
Precedence: bulk
X-list: linux-mips

Rodolfo Giometti wrote:
> Hello,
> 
> here a patch to add cursor enable/disable, very useful if you wish a
> full screen boot logo.
> 
> Cursor can be disabled from kernel command line:
> 
>    video=au1100fb:nocursor,panel:Toppoly_TD035STED4
> 
> or from sysfs interface:
> 
>    echo 1 > /sys/module/au1100fb/parameters/nocursor
> 
> The patch also fixes up some wrong indentation issues.

I'm getting rejects with this patch and with the startup patch.
I'm manually fixing it but please check if its okay.

Tony
 
