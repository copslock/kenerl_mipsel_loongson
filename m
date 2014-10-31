Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 16:58:11 +0100 (CET)
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:52174 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012297AbaJaP6HaXqcP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 16:58:07 +0100
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-12v.sys.comcast.net with comcast
        id 9rxm1p0015AAYLo01ry1fW; Fri, 31 Oct 2014 15:58:01 +0000
Received: from gentwo.org ([98.213.233.247])
        by resomta-po-15v.sys.comcast.net with comcast
        id 9rHG1p00F5Lw0ES01rHGHZ; Fri, 31 Oct 2014 15:17:18 +0000
Received: by gentwo.org (Postfix, from userid 1001)
        id 3D1D5182; Fri, 31 Oct 2014 10:17:16 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 39827140;
        Fri, 31 Oct 2014 10:17:16 -0500 (CDT)
Date:   Fri, 31 Oct 2014 10:17:16 -0500 (CDT)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@gentwo.org
To:     Joonsoo Kim <iamjoonsoo.kim@lge.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH for v3.18] mm/slab: fix unalignment problem on Malta with
 EVA due to slab merge
In-Reply-To: <1414742912-14852-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.11.1410311015490.14859@gentwo.org>
References: <1414742912-14852-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1414771081;
        bh=eI+/L5PEzDfYM0gKAgC0QopUBCuWSky5bsnL260oZb4=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Content-Type;
        b=ZWDiQ/UTSvsACwLxou6foKmHS867/TG3l3qmEcEnMB0Tz11bmlOSELkj61381+pO5
         rBJ2Fg0zGyLqK6vLjH1Qpv/FwMXTFvY9PUnfW2pgoa+BZ+juF06K5BTFrhoowXH//4
         SIBKe20S/2QkRhlUw/zgPTGWQFXY5UYCe+DNiM3ljC6WdgLYEUWM2LnMB0TaLEaa1d
         k1P/NAF74YVLD+ZenQCOams99KW0F9zMEEOG4/PfRIcaWn2iPOsVcj1xqZdbE/doGt
         zUPXGqgEhis5mKPeFaar4lQgKnhIqpOOEI/CHOrPZxeR2Z9CRE2KZOnZtLiUDhbViv
         QKuhT36qUjX2w==
Return-Path: <cl@linux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux.com
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

On Fri, 31 Oct 2014, Joonsoo Kim wrote:

> alloc_unbound_pwq() allocates slab object from pool_workqueue. This
> kmem_cache requires 256 bytes alignment, but, current merging code
> doesn't honor that, and merge it with kmalloc-256. kmalloc-256 requires
> only cacheline size alignment so that above failure occurs. However,
> in x86, kmalloc-256 is luckily aligned in 256 bytes, so the problem
> didn't happen on it.

That luck will run out when you enable debugging. But then that also
usually means disablign merging.

> To fix this problem, this patch introduces alignment mismatch check
> in find_mergeable(). This will fix the problem.

Acked-by: Christoph Lameter <cl@linux.com>
