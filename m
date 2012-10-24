Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2012 18:56:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57946 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825702Ab2JXQ4RSiutd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Oct 2012 18:56:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9OGuFRf016259;
        Wed, 24 Oct 2012 18:56:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9OGuC5Z016257;
        Wed, 24 Oct 2012 18:56:12 +0200
Date:   Wed, 24 Oct 2012 18:56:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maarten ter Huurne <maarten@treewalker.org>
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, linux-mips@linux-mips.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 11/13] MIPS: JZ4750D: Add Kbuild files
Message-ID: <20121024165612.GD13637@linux-mips.org>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
 <1351014241-3207-12-git-send-email-antonynpavlov@gmail.com>
 <4796718.WhuB0k6pfC@hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796718.WhuB0k6pfC@hyperion>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34769
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

On Wed, Oct 24, 2012 at 06:16:35PM +0200, Maarten ter Huurne wrote:

> What is the purpose of padding the load address to 64 bits?
> 
> The reason I'm asking is that we encountered a bug with that when creating a 
> u-boot image on a 32-bit host machine: the mkimage tool will only parse the 
> first 8 hex digits and then inserts the wrong load address into the uImage.

Ld internally uses 64 bit addresses.  Also, for platforms that support
32 bit and 64 bit kernels we'd have to specify two values that only differ
by the sign extension in the upper bits.

  Ralf
