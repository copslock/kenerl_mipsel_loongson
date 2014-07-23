Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 09:03:23 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:40311 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842441AbaGWHDVWWQUC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 09:03:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 9BB14462A92;
        Wed, 23 Jul 2014 08:03:15 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 564VTQgdE+1r; Wed, 23 Jul 2014 08:03:13 +0100 (BST)
Received: from humdrum (unknown [10.24.1.221])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 556CE460C33;
        Wed, 23 Jul 2014 08:03:13 +0100 (BST)
Date:   Wed, 23 Jul 2014 08:03:10 +0100
From:   Rob Kendrick <rob.kendrick@codethink.co.uk>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
Message-ID: <20140723070309.GM30723@humdrum>
References: <20140722130616.GJ30723@humdrum>
 <53CE82B6.1070902@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53CE82B6.1070902@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <rob.kendrick@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob.kendrick@codethink.co.uk
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

On Tue, Jul 22, 2014 at 05:26:46PM +0200, John Crispin wrote:
> we had a quite some trouble adding support to openwrt. in the end we
> needed a few uclibc patches and gxx4.8 seems utterly foo'ed on this.
> gcc 4.6 and 4.9 seem to be running fine though.
> 
> what compiler, libc, ... version are you using ?

mips64-unknown-linux-gnu-gcc (crosstool-NG git+7f1c646) 4.9.0
eglibc 2.15

But this does indeed appear problem with the kernel and not the
toolchain.  Sadly I can't opt for softfloat with this.  I'm going to be
trying to look at the patch that Markos identified; it looks like it may
have mixed up MIPSInst_RT and MIPSInst_FD in a copy-and-paste.
(Guessing, new to MIPS.)

Thanks everyone for your help so far!

-- 
Rob Kendrick, Senior Consulting Developer                Codethink Ltd.
Telephone: +44 7880 657 193              302 Ducie House, Ducie Street,
http://www.codethink.co.uk/         Manchester, M1 2JW, United Kingdom.
