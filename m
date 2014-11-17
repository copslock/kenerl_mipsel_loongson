Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 17:38:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18559 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013851AbaKQQiY3Gofu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 17:38:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CBC59B5A74A6C;
        Mon, 17 Nov 2014 16:38:15 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 17 Nov
 2014 16:38:18 +0000
Received: from [192.168.159.30] (192.168.159.30) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 08:38:16 -0800
Message-ID: <546A2474.3080907@imgtec.com>
Date:   Mon, 17 Nov 2014 10:38:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/7] MIPS: Kconfig: Enable microMIPS support for Malta
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk> <alpine.DEB.1.10.1411152040190.2881@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1411152040190.2881@tp.orcam.me.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.30]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 11/15/2014 04:07 PM, Maciej W. Rozycki wrote:
> Add missing microMIPS support to Malta.  Currently the kernel only 
> enables support for the instruction set for the SEAD-3 board despite the 
> fact processor features have nothing to do with the board a processor is 
> installed in.
> 
For years there have been no microMIPS cores designed for the Malta
platform. Only now since you are trying to use microMIPS on QEMU is this
an issue. It was also the quick and dirty way to make sure microMIPS
kernels could not be used without changing the platform. Still, this is
certainly correct and I like it. Thanks.

Steve
