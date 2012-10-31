Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:29:00 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49795 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825887Ab2JaN2xivnJx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 14:28:53 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9VDSp5j007180;
        Wed, 31 Oct 2012 14:28:51 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9VDSoc7007178;
        Wed, 31 Oct 2012 14:28:50 +0100
Date:   Wed, 31 Oct 2012 14:28:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 03/15] MIPS: Netlogic: select MIPSR2 for XLP
Message-ID: <20121031132850.GB6365@linux-mips.org>
References: <cover.1351688140.git.jchandra@broadcom.com>
 <3172102a3b041fdefbc721e3a25a95427bdec384.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3172102a3b041fdefbc721e3a25a95427bdec384.1351688140.git.jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34812
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

On Wed, Oct 31, 2012 at 06:31:29PM +0530, Jayachandran C wrote:

> Disable PGD_C0_CONTEXT option for XLP, which does not work.

Why does this not work on XLP?

  Ralf
