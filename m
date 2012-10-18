Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2012 11:45:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37352 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817534Ab2JRJpf3ign5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Oct 2012 11:45:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9I9jYmK029630;
        Thu, 18 Oct 2012 11:45:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9I9jXQo029629;
        Thu, 18 Oct 2012 11:45:33 +0200
Date:   Thu, 18 Oct 2012 11:45:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     jerin jacob <jerinjacobk@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS:CMP Fix physical core number calculation logic
Message-ID: <20121018094533.GA28896@linux-mips.org>
References: <1349974131-5856-1-git-send-email-jerinjacobk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1349974131-5856-1-git-send-email-jerinjacobk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34722
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

On Thu, Oct 11, 2012 at 10:18:51PM +0530, jerin jacob wrote:

> CPUNum Field in EBase register is 10bit wide, so after 1 bit right shift, mask
> value should be 0x1ff

Fortunately nobody has a CMP with more than 256 cores yet :-)

Applied.  Thanks,

  Ralf
