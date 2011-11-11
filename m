Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 14:32:54 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58364 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903966Ab1KKNcl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 14:32:41 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pABDWFV1012158;
        Fri, 11 Nov 2011 13:32:15 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pABDWEYP012156;
        Fri, 11 Nov 2011 13:32:14 GMT
Date:   Fri, 11 Nov 2011 13:32:14 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2 5/8] MIPS: BMIPS: Introduce bmips.h
Message-ID: <20111111133214.GF28303@linux-mips.org>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
 <82d0f7976bd482696b7dfefe4953859b@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d0f7976bd482696b7dfefe4953859b@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10293

On Thu, Nov 10, 2011 at 10:30:28PM -0800, Kevin Cernekee wrote:

> +	__asm__ __volatile__(
> +		".set push\n"
> +		".set noreorder\n"
> +		"cache %1, 0(%2)\n"
> +		"sync\n"
> +		"ssnop\n"

Ssnop was added relatively recently to gas and the kernel supports building
with much older toolchains.  To get around this <asm/hazard.h> defines
a _ssnop macro.

  Ralf
