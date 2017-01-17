Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 19:00:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39960 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993899AbdAQSAgmmaz0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 19:00:36 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0HI0Zsv032096;
        Tue, 17 Jan 2017 19:00:35 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0HI0XBD032095;
        Tue, 17 Jan 2017 19:00:33 +0100
Date:   Tue, 17 Jan 2017 19:00:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nsn.com>,
        David Daney <david.daney@cavium.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] octeon: prom_putchar() must be void
Message-ID: <20170117180033.GK31072@linux-mips.org>
References: <20170117173644.27984-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117173644.27984-1-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56367
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

On Tue, Jan 17, 2017 at 06:36:44PM +0100, Alexander Sverdlin wrote:
> Date:   Tue, 17 Jan 2017 18:36:44 +0100
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> To: unlisted-recipients: no To-header on input <;
> CC: Alexander Sverdlin <alexander.sverdlin@nsn.com>, Alexander Sverdlin
>  <alexander.sverdlin@nokia.com>, Ralf Baechle <ralf@linux-mips.org>, David
>  Daney <david.daney@cavium.com>, Aaro Koskinen <aaro.koskinen@nokia.com>,
>  "Steven J. Hill" <steven.hill@cavium.com>, linux-mips@linux-mips.org
> Subject: [PATCH] octeon: prom_putchar() must be void
> Content-Type: text/plain
> 
> From: Alexander Sverdlin <alexander.sverdlin@nsn.com>
> 
> Correct the function return type.

Thanks Alexander.  There is another instance of the same issue in
arch/mips/ar7/prom.c which I'm going to take care of.

  Ralf
