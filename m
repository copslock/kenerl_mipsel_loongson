Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 19:53:56 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35191 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011901AbcBLSxzgyAAb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Feb 2016 19:53:55 +0100
Received: by mail-pa0-f68.google.com with SMTP id fl4so4129143pad.2;
        Fri, 12 Feb 2016 10:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KaarVcINqAP1S6IRRhLRkTqtgAH/EjK6pyN/DFSV8gQ=;
        b=H8KAoRDgECE+4G5KzRgNIQOeHyiOUI1ujh7+NRQTbJ5br/8y+yeDWcLCvxpeWRc2ea
         TPuj+/NMyPRIQSt8Cd3Y61s3dPAbasnxFqzRL6toCkbOHVhgllwQ6bockfXmNU6iAKf3
         2O63MMerFtM7MOQXLyu0IP5c6rVrbYrEpfuMVErKE1gysvOrushsZwk21K/0VCP/se+l
         lgYfDPCyvYKvqzMwOj4zO4PGLaOmqs0MOqYtY4UANhVoqWPNtaULUNbw5hYD51Gcc4CK
         NkWG6W7e4h2rSllOnF8lUNtHPujfx/vQ9oVnFOywGQ0JHkg6zNbEd71HJLgzw5Qt4ydw
         lRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KaarVcINqAP1S6IRRhLRkTqtgAH/EjK6pyN/DFSV8gQ=;
        b=B5PEdVKnYIdOHvO5VzvP5i30Z5WalhcvjZGQ5BC1SlrIQYQVXlUTDxTD6uRLlP9hjI
         zpibGZ4R9NaX7P8fie1dsVqjgD3j8GlsiFBrA4h7du0gT7V7dvkz8ITGkzUopN/2ieO6
         baTFDILWekU0YMYGtuBUZp7xOl7LrXSh4OU4SzOmwdKYPDeCYMkRCFaBtLi4FzNftb2a
         uOPXrXwoxZTH0tfNvth8mMJBRr/FPdH9ZegVSbxPweaLJ+pZbVC91sRaM2SU+wRtSBDc
         maN0N38vg02Ro/j2WB2/1CeLBgz6UWZxgHt3pHJnq342hRi/6s2zMAvY/ikJaprH9X0n
         AF6g==
X-Gm-Message-State: AG10YORy23SpE7rmdjbme8SOwZByHd5iBppi8SemLkbkP5BhOuPUDXRS0yvEVZKEfkcxLw==
X-Received: by 10.66.55.102 with SMTP id r6mr4286780pap.67.1455303229966;
        Fri, 12 Feb 2016 10:53:49 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:7c71:7f64:5e00:7fed])
        by smtp.gmail.com with ESMTPSA id fl9sm21109761pab.30.2016.02.12.10.53.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 10:53:49 -0800 (PST)
Date:   Fri, 12 Feb 2016 10:53:47 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Simon Arlott <simon@fire.lp0.eu>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        sfr@canb.auug.org.au
Subject: Re: [PATCH linux-next v4 07/11] MIPS: bcm63xx: nvram: Remove unused
 bcm63xx_nvram_get_psi_size() function
Message-ID: <20160212185347.GA21465@google.com>
References: <566DF43B.5010400@simon.arlott.org.uk>
 <566DF625.3060801@simon.arlott.org.uk>
 <20160126191607.GA111152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126191607.GA111152@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi Ralf,

On Tue, Jan 26, 2016 at 11:16:07AM -0800, Brian Norris wrote:
> On Sun, Dec 13, 2015 at 10:50:13PM +0000, Simon Arlott wrote:
> > Remove bcm63xx_nvram_get_psi_size() as it now has no users.
> > 
> > Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> > ---
> > v4: New patch.
> 
> Ralf,
> 
> Please revert this and send it to Linus (or else, I can send it myself).
> This is causing build failures, because I didn't take the rest of
> Simon's series yet.
> 
> drivers/mtd/bcm63xxpart.c: In function 'bcm63xx_parse_cfe_partitions':
> drivers/mtd/bcm63xxpart.c:93:2: error: implicit declaration of function 'bcm63xx_nvram_get_psi_size' [-Werror=implicit-function-declaration]
> 
> I will reply to the series if/when I accept any patches from it. I would
> appreciate it if you would do the same.

I see that the revert made it to Linus. Thanks!

I've now pushed the dependent pieces to l2-mtd.git, and they should make
it to v4.6-rc1. So I guess it's fair game to re-apply this patch?
Although, if you don't merge in my MTD branch first, you'd still be
breaking bisectability... Maybe it's a post-rc1 candidate?

Brian
