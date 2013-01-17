Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 15:05:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46212 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832832Ab3AQOFQ4nW6v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Jan 2013 15:05:16 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0HE5Eai026534;
        Thu, 17 Jan 2013 15:05:14 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0HE5Alw026533;
        Thu, 17 Jan 2013 15:05:10 +0100
Date:   Thu, 17 Jan 2013 15:05:10 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "cernekee@gmail.com" <cernekee@gmail.com>,
        "kevink@paralogos.com" <kevink@paralogos.com>
Subject: Re: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Message-ID: <20130117140510.GA19406@linux-mips.org>
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>
 <50F5B0D0.9010604@gmail.com>
 <31E06A9FC96CEC488B43B19E2957C1B801146C51CC@exchdb03.mips.com>
 <50F5DA93.2080706@gmail.com>
 <20130116141618.GC26569@linux-mips.org>
 <50F7289A.3000102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50F7289A.3000102@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35479
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

On Wed, Jan 16, 2013 at 02:24:26PM -0800, David Daney wrote:

> ... In the very last BITFIELD_FIELD(), you need a valid token as the
> second parameter, otherwise (according to Pinski) C90 behavior is
> undefined.
> 
> Use a ';'

While Andrew is correct, I don't think this argument matters unless
we're going to export <asm/inst.h> to userspace.  Should we?  Historically
it was meant to be exported and accessed by application code from
<sys/inst.h>.

  Ralf
