Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 09:25:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59789 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832188Ab3AOIZAhC-H- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Jan 2013 09:25:00 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0F8Ow27012004;
        Tue, 15 Jan 2013 09:24:58 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0F8OuVD012003;
        Tue, 15 Jan 2013 09:24:56 +0100
Date:   Tue, 15 Jan 2013 09:24:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com, kevink@paralogos.com
Subject: Re: [PATCH] [RFC] Proposed changes to eliminate 'union
 mips_instruction' type.
Message-ID: <20130115082456.GA17364@linux-mips.org>
References: <1358230420-3575-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358230420-3575-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35443
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

On Tue, Jan 15, 2013 at 12:13:40AM -0600, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> This patch shows the use of macros in place of 'union mips_instruction'
> type. I converted all usages of 'j_format' and 'r_format' to show how
> the code and macros could look and be defined. I have tested these
> changes on big and little endian platforms.
> 
> I want input from everyone, please!!! I want consensus on the macro
> definitions, placement of parenthesis for them, spacing in the header
> file, etc. This is your chance to be completely anal and have fun
> arguments over how things should be. I would also like input on how
> the maintainers would like the patchsets to look like. For example:
> 
>   [1/X] - Convert 'j_format'
>   [2/X] - Convert 'r_format'
>   [3/X] - Convert 'f_format'
>   [4/X] - Convert 'u_format'
>   ...
>   [X/X] - Remove usage of 'union mips_instruction' type completely.
> 
> Also, I noticed 'p_format' is not used anywhere. Can we kill it? Be
> picky and help with this conversion. Thanks.

Mayne not kill it completely abut leave a comment mentioning its existence
for the sake of completeness.

  Ralf
