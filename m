Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 08:32:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990437AbeKWHadjJbYT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Nov 2018 08:30:33 +0100
Received: from localhost (unknown [40.114.107.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E544820861;
        Fri, 23 Nov 2018 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542958232;
        bh=FiCDtrn2TJ7QNnw/0Qlqo5XiIab9DrroFiYvC51RGug=;
        h=Date:From:To:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
         References:From;
        b=TvwZInqG667PVLFuXrsJ5VMLtTKY8Q28oF5dBUJROU3Pyydm/YKGHzXaryrLcqUE+
         /oLPB+AGG9y6kODxA/oFz/wiuNy+BYQ6H35zgkW/KsEQIkbf6tBU0hHOYEhNzSx5F4
         A6Cp3xDTpIAfQBWjEr0R0VehCkVEX3DZuPB/Snxo=
Date:   Fri, 23 Nov 2018 07:30:31 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
Cc:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org
Cc:     stable@kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [for-next][PATCH 06/18] MIPS: function_graph: Simplify with function_graph_entry()
In-Reply-To: <20181122003332.209589047@goodmis.org>
References: <20181122003332.209589047@goodmis.org>
Message-Id: <20181123073031.E544820861@mail.kernel.org>
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 03274a3ffb44 tracing/fgraph: Adjust fgraph depth before calling trace return callback.

The bot has tested the following trees: v4.19.3, v4.14.82, v4.9.138, v4.4.164, v3.18.126.

v4.19.3: Build OK!
v4.14.82: Build OK!
v4.9.138: Failed to apply! Possible dependencies:
    Unable to calculate

v4.4.164: Failed to apply! Possible dependencies:
    Unable to calculate

v3.18.126: Failed to apply! Possible dependencies:
    Unable to calculate


How should we proceed with this patch?

--
Thanks,
Sasha
