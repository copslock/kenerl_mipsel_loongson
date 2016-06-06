Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 18:41:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46702 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27042688AbcFFQlNAgFru (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2016 18:41:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u56GfC4b017737;
        Mon, 6 Jun 2016 18:41:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u56GfCUH017736;
        Mon, 6 Jun 2016 18:41:12 +0200
Date:   Mon, 6 Jun 2016 18:41:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hugh =?iso-8859-1?Q?Sipi=E8re?= <hgsipiere@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] drivers: ssb: Change bare unsigned to unsigned int to
 suit coding style
Message-ID: <20160606164112.GA17718@linux-mips.org>
References: <1465057021-10280-1-git-send-email-hgsipiere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1465057021-10280-1-git-send-email-hgsipiere@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53890
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

On Sat, Jun 04, 2016 at 05:17:01PM +0100, Hugh Sipière wrote:

> These lines just have unsigned gpio rather than unsigned int gpio.
> I changed it to suit the coding style. Michael Buesch told me to
> send this to the MIPS tree.

Thanks, applied.

  Ralf
