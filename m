Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 23:48:49 +0000 (GMT)
Received: from xproxy.gmail.com ([66.249.82.207]:29445 "EHLO xproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3458400AbWAWXsb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 23:48:31 +0000
Received: by xproxy.gmail.com with SMTP id s18so707512wxc
        for <linux-mips@linux-mips.org>; Mon, 23 Jan 2006 15:52:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MkbGFJxD9Uq8qz/3SePvCA3pe+EWvLGIcCiLuA1/uc/9RX6ZDP2/mMMIIdNMowBw1QWjNtLzLpjhQwjSRK0q0iIxM6N5DYndyGsAX74GpHpLCXrvqqmySfzRf1taWpPjy6s3l/4L2rJBGdHzWWPJ+mO+hQVsf9ydB7TCHe0h7TM=
Received: by 10.70.45.12 with SMTP id s12mr5635326wxs;
        Mon, 23 Jan 2006 15:52:40 -0800 (PST)
Received: from ?192.168.232.98? ( [203.84.188.34])
        by mx.gmail.com with ESMTP id i12sm7891388wxd.2006.01.23.15.52.37;
        Mon, 23 Jan 2006 15:52:40 -0800 (PST)
Message-ID: <43D56C60.4030402@gmail.com>
Date:	Tue, 24 Jan 2006 07:53:04 +0800
From:	"Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	linux-fbdev-devel@lists.sourceforge.net
CC:	linux-mips@linux-mips.org, kumba@gentoo.org
Subject: Re: [Linux-fbdev-devel] [PATCH]: Fix SGI O2 Compile error in drivers/video/gbefb.c
References: <20060123203205.GB499@toucan.gentoo.org>
In-Reply-To: <20060123203205.GB499@toucan.gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <adaplas@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adaplas@gmail.com
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Hi all,
> 
> Around line ~1247 in drivers/video/gbefb.c, gbefb_remove_sysfs uses the wrong parameter, causing an O2 kernel build 
> to break when using this driver.  The attached patch supplies the correct parameter, allowing the build to succeed.
> 

Okay.  Thanks.

Tony
