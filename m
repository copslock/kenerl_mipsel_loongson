Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Mar 2013 21:48:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34581 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824755Ab3CMUsJsvTWd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Mar 2013 21:48:09 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2DKm8xu018722;
        Wed, 13 Mar 2013 21:48:08 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2DKm6aG018721;
        Wed, 13 Mar 2013 21:48:06 +0100
Date:   Wed, 13 Mar 2013 21:48:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com,
        kevink@paralogos.com, ddaney.cavm@gmail.com
Subject: Re: [PATCH 0/4] Add support for microMIPS instructions
Message-ID: <20130313204806.GA16745@linux-mips.org>
References: <1360104723-29529-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1360104723-29529-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35886
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

On Tue, Feb 05, 2013 at 04:51:59PM -0600, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> These patches add support for the microMIPS ISA. The kernel can
> simultaneously support classic and microMIPS instructions using
> the micro assembler. All microMIPS instructions for the micro
> assembler have the 'MM_' prefix.

Finally spanking clean and shiny I've applied the series with the one
final nit noted by Sergei fixed.

Thanks!

  Ralf
