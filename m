Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 19:10:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57271 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab2JJRKDr0p9r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 19:10:03 +0200
Date:   Wed, 10 Oct 2012 18:10:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Rich Felker <dalias@aerifal.cx>, linux-mips@linux-mips.org,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Subject: Re: 2GB userspace limitation in ABI N32
In-Reply-To: <5075A8D8.2080704@gmail.com>
Message-ID: <alpine.LFD.2.02.1210101805410.21287@eddie.linux-mips.org>
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com> <20121010080756.GC6740@linux-mips.org> <20121010125700.GR254@brightrain.aerifal.cx> <5075A8D8.2080704@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34676
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 10 Oct 2012, David Daney wrote:

> The only disadvantage of doing this is that the code will be slightly
> larger/slower as it takes three instructions to load a zero extended 32-bit
> pointer verses two for n32-2GB.

 And of course such code will only run on 64-bit processors that not only 
support 64-bit data, but 64-bit addressing as well.  That is implement the 
CP0.Status.UX bit rather than CP0.Status.PX only -- the latters are still 
compatible with the true n32 ABI.  See also CP0.Config.AT.

  Maciej
