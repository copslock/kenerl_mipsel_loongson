Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2011 15:00:42 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54815 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903592Ab1KNOAb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2011 15:00:31 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAEE0VDH019050;
        Mon, 14 Nov 2011 14:00:31 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAEE0U0r019048;
        Mon, 14 Nov 2011 14:00:30 GMT
Date:   Mon, 14 Nov 2011 14:00:30 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2] MIPS: lantiq: use export.h in favour of module.h
Message-ID: <20111114140030.GA17600@linux-mips.org>
References: <1320957187-26693-1-git-send-email-blogic@openwrt.org>
 <1320957187-26693-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320957187-26693-2-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11593

On Thu, Nov 10, 2011 at 09:33:07PM +0100, John Crispin wrote:

> The code located at arch/mips/lantiq/ included module.h to be able to use the
> EXPORT_SYMBOL* macros. These can now be directly included using export.h.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org

Thanks, applied.

  Ralf
