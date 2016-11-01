Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 14:49:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58239 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993145AbcKANthE7Zxe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 14:49:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A4E396027C247;
        Tue,  1 Nov 2016 13:49:27 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 1 Nov 2016
 13:49:30 +0000
Date:   Tue, 1 Nov 2016 13:49:23 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Deepak Gaur <dgaur@cdot.in>
CC:     <linux-mips@linux-mips.org>
Subject: Re: System clock going slow/fast with ntpdate
In-Reply-To: <20161026085306.M18729@cdot.in>
Message-ID: <alpine.DEB.2.00.1611011343100.24498@tp.orcam.me.uk>
References: <20161026081208.M10605@cdot.in> <20161026085306.M18729@cdot.in>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 26 Oct 2016, Deepak Gaur wrote:

> I have board with MIPS 34Kc processor and linux-2.6.29 with 
> CONFIG_HZ_250=y set in kernel configuration (i.e 250 timer interrupts 
> per 1 real second in /proc/interrupts).
[...]
> Please help me in understanding this behaviour of NTP with MIPS Linux 
> and possible fixes if any. Is it a kernel bug or a configuration issue?

 Your Linux kernel is very old, version 2.6.29 was released over 8 years 
ago.  Please try a recent kernel such as 4.8.0 instead so that you don't 
miss all the important fixes and updates.

 If you find yourself still having issues with an updated kernel, then 
please come back and we'll try to help.

  Maciej
