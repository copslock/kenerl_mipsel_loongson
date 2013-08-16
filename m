Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 22:27:22 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39594 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831315Ab3HPU1LiCa1D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 22:27:11 +0200
Received: by mail-pd0-f172.google.com with SMTP id z10so2681079pdj.31
        for <linux-mips@linux-mips.org>; Fri, 16 Aug 2013 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ntfbGKCd1pD/tkOtof463lXLF/EwiriQpwoixK6sv+w=;
        b=DXiBiwv4gv326kBW9rjfnZNZtlRGSEyzvnj2WhTzrTfIioye5JWqpTXM7zkQrBhLOu
         cj7DYijR8Q8KlPLCEPPvetZo8UutfFUtsmxUJvY6IH1HDw4VXRL5GFhrxnAl3aB993Du
         TFNb6PnDCbuVLq9bkzbeop4fYG1p5ZgIxx1OOUsE1ASkslPVy8NgdfjGc9HnYUIBZl83
         f6ZZc+d2GLpV+bzIKc8yn3W8/JFHGEQLaop+yAkTEItOBKGO4XTpUTnGmi62mypLRdoz
         7aE4ZNZQXfThG36ReR8aFhem+0zX3d9t8z3t2OSU9OvQRoeTQE7bzh7WwDgkfUSP8tTr
         EwVA==
X-Received: by 10.66.234.193 with SMTP id ug1mr4932777pac.92.1376684825257;
        Fri, 16 Aug 2013 13:27:05 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id z14sm3943147pbt.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 13:27:04 -0700 (PDT)
Date:   Fri, 16 Aug 2013 13:27:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [ 00/17] 3.4.58-stable review
Message-ID: <20130816202702.GD4568@roeck-us.net>
References: <520A1D56.2050507@roeck-us.net>
 <20130813175858.GC7336@kroah.com>
 <20130813201936.GA18358@roeck-us.net>
 <20130815063158.GB25754@kroah.com>
 <520C86BD.2020903@roeck-us.net>
 <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
 <520DB045.7000309@roeck-us.net>
 <20130816051041.GA23784@kroah.com>
 <520DE21D.8000905@roeck-us.net>
 <20130816124140.GD24550@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130816124140.GD24550@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Aug 16, 2013 at 05:41:40AM -0700, Greg Kroah-Hartman wrote:
> On Fri, Aug 16, 2013 at 01:26:05AM -0700, Guenter Roeck wrote:
> > On 08/15/2013 10:10 PM, Greg Kroah-Hartman wrote:
> > [ .. ]
> > 
> > >> three to go (arm:allmodconfig, sparc32:defconfig, and sparc64:allmodconfig).
> > >
> > 
> > Please add (in this order) the following patches to 3.4.
> > 
> > de36e66d5f sparc32: add ucmpdi2
> > 74c7b28953 sparc32: Add ucmpdi2.o to obj-y instead of lib-y.
> > 
> > This fixes the sparc32:defconfig build error.
> 
> Now applied, thanks.
> 
Down to three failures now, out of 69 builds.

Still failing:
	arm:allmodconfig
	sparc64:allmodconfig
	xtensa:defconfig

None of those appear simple to fix.

In case someone wants to have a look, here is the latest log:

http://server.roeck-us.net:8010/builders/stable-queue-3.4/builds/45/steps/shell/logs/stdio
	
Guenter
