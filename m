Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 01:02:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:12956 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039163AbWI2ACW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 01:02:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8T02a37009643;
	Fri, 29 Sep 2006 01:02:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8T02Xhs009642;
	Fri, 29 Sep 2006 01:02:33 +0100
Date:	Fri, 29 Sep 2006 01:02:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Neo <cjia@cse.unl.edu>
Cc:	linux-mips@linux-mips.org
Subject: Re: How to build the glibc for MIPS?
Message-ID: <20060929000233.GG3394@linux-mips.org>
References: <451C537B.7060507@cse.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451C537B.7060507@cse.unl.edu>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 28, 2006 at 05:58:03PM -0500, Neo wrote:

> I have successfully built the cross toolchain excluding glibc following 
> the steps of www.linux-mips.org. Now, I am wondering how to build the 
> glibc for MIPS. The websites provided by linux-mips are not accessible 
> any more or they cannot be built successfully.

Are you refering to the instructions in the old MIPS-HOWTO document?
I've asked LDP to remove it because it was so obsolete.  Building glibc
has fortunately become much easier these days; it's mostly a question of
getting the build environment right.

  Ralf
