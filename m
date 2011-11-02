Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2011 14:21:32 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54746 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903949Ab1KBNV2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Nov 2011 14:21:28 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA2DLQTm018668;
        Wed, 2 Nov 2011 13:21:26 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA2DLO4t018663;
        Wed, 2 Nov 2011 13:21:24 GMT
Date:   Wed, 2 Nov 2011 13:21:24 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Jarosch <thomas.jarosch@intra2net.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix off-by-two in arcs_cmdline buffer size check
Message-ID: <20111102132123.GA18568@linux-mips.org>
References: <4EAC0394.5000807@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EAC0394.5000807@intra2net.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1231

On Sat, Oct 29, 2011 at 03:45:56PM +0200, Thomas Jarosch wrote:

> Cause is a misplaced bracket.
> 
> The code
> 
>     strlen(buf+1)
> 
> will be two bytes less than
> 
>     strlen(buf)+1
> 
> The +1 is in this code to reserve space for an additional space character.

Thanks, applied.

The same buggy code just formatted slightly differently also exists in
Emma.  I added the Emma fix to the patch and applied it.

Thanks!

  Ralf
