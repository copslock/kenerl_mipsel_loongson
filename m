Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 10:27:14 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.193]:62804 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133406AbWBBK04 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 10:26:56 +0000
Received: by zproxy.gmail.com with SMTP id l8so358432nzf
        for <linux-mips@linux-mips.org>; Thu, 02 Feb 2006 02:32:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IwnSh17fGssg17Zrj+LQIYsW3KTVb/V/kj7WxGBWBc6X2cVzSVj4DbmDOHZxnddkifYTybJhHB9I9HnrM7AtH0VE8swo1El9j1P4/MCveXEgxrwv/of5Ak+4W5smh1PXXfcQGmsMYqcJpmCL7LFUWsjGs+wZajaeSVbyjZd0TT8=
Received: by 10.36.41.19 with SMTP id o19mr512612nzo;
        Thu, 02 Feb 2006 02:32:05 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 2 Feb 2006 02:32:05 -0800 (PST)
Message-ID: <cda58cb80602020232r36241faeh@mail.gmail.com>
Date:	Thu, 2 Feb 2006 11:32:05 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Optimize swab operations
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20060126120114.GD3411@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601260308v3eecf0d0w@mail.gmail.com>
	 <20060126120114.GD3411@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Jan 26, 2006 at 12:08:25PM +0100, Franck wrote:
>
> Applied.
>

I'm a bit disapointed the way you do it. You changed the patch
(wrongly) and the authorships. At least you could have said: "thanks
to" in your commit message. Bad experience for my first patch...

--
               Franck
