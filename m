Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 20:15:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41327 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6833413Ab3AWTPvxZD-v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 20:15:51 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0NJFomo008685;
        Wed, 23 Jan 2013 20:15:50 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0NJFoFc008684;
        Wed, 23 Jan 2013 20:15:50 +0100
Date:   Wed, 23 Jan 2013 20:15:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: git (linux-queue.git) not available: access denied or repository
 not exported
Message-ID: <20130123191549.GB7294@linux-mips.org>
References: <CACna6rz2mpRUZsXqDr7wDjgTSz0bunq9wZ9PumyR5gO_cRhS1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6rz2mpRUZsXqDr7wDjgTSz0bunq9wZ9PumyR5gO_cRhS1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35519
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

On Wed, Jan 23, 2013 at 11:45:16AM +0100, Rafał Miłecki wrote:

> # git clone git://git.linux-mips.org/pub/scm/ralf/linux-queue.git
> Cloning into 'linux-queue'...
> fatal: remote error: access denied or repository not exported:
> /pub/scm/ralf/linux-queue.git
> 
> I've tried this on two machines. Is there some mirror?

The repository has been superseeded by upstream-sfr.git.  linux-queue.git
used to serve almost the same purpose and has been dropped.

Is there a stale reference to linux-queue.git somewhere?

  Ralf
