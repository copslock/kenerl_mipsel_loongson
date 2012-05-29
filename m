Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2012 10:48:41 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:50456 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903544Ab2E2Ise (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 May 2012 10:48:34 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4T8mWj4032561;
        Tue, 29 May 2012 09:48:32 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4T8mVgG032553;
        Tue, 29 May 2012 09:48:31 +0100
Date:   Tue, 29 May 2012 09:48:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        Douglas Leung <douglas@mips.com>
Subject: Re: [PATCH] MIPS: Add support for the MIPS32 4Kc family I/D caches.
Message-ID: <20120529084831.GC9944@linux-mips.org>
References: <1337614412-29035-1-git-send-email-sjhill@mips.com>
 <20120522173245.GB5884@linux-mips.org>
 <alpine.LFD.2.00.1205270312110.3701@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1205270312110.3701@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, May 27, 2012 at 03:19:47AM +0100, Maciej W. Rozycki wrote:

>  It was not a bug, or at least not an active one.  The new encoding was 
> only added with revision 3 of the architecture or thereabouts, so not so 
> long ago.  It used to be reserved previously, so we just handled it 
> arbitrarily (though perhaps we should have panicked instead on 
> encountering it indeed).

The patch at least was applicable to all 2.4 and 2.6 branches ...

  Ralf
