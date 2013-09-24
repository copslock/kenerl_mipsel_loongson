Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 01:37:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45432 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818991Ab3IXXhmHkWVt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 01:37:42 +0200
Date:   Wed, 25 Sep 2013 00:37:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Tell R4k SC and MC variations apart
In-Reply-To: <20130924084845.GA21257@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309250019490.17450@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org> <20130924084845.GA21257@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 24 Sep 2013, Ralf Baechle wrote:

> My reservations may have been about userland reading /proc/cpuinfo and
> looking at the CPU type.  Some software may know how to handle the
> PC/SC variants but not the MC versions.  But this seems to be a fairly
> weak concern - and I trust you checked gcc's parsing of /proc/cpuinfo.

 Actually I wasn't actually aware GCC's got /proc/cpuinfo-based native 
arch support for the MIPS target these days, thanks for the hint.

 I have now checked the relevant source file and support is pretty weak 
there, only half a dozen processors are recognised and no R4k model is 
among them.  In any case strstr is used to check for matches there so I'd 
expect strings like "R4000" or "R4400" without a further suffix to be 
chosen.

  Maciej
