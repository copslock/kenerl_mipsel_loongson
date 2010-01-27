Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 15:05:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60779 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493558Ab0A0OFK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2010 15:05:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0RE5JDR002820;
        Wed, 27 Jan 2010 15:05:19 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0RE5JW0002818;
        Wed, 27 Jan 2010 15:05:19 +0100
Date:   Wed, 27 Jan 2010 15:05:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH -queue] MIPS: Simplify the weak annotation with __weak
Message-ID: <20100127140519.GC18247@linux-mips.org>
References: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
 <0dd2da661e29d1ba6ade77374c06a85011849b35.1264517876.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd2da661e29d1ba6ade77374c06a85011849b35.1264517876.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17522

On Tue, Jan 26, 2010 at 11:02:34PM +0800, Wu Zhangjin wrote:

> There was a __weak define as __attribute__((weak)) there, this patch
> just use it to simplify the weak annotation.

Nice cleanup; I've made it bulletproof by including <linux/compiler.h>
which defines __weak.

Queued for 2.6.34.

  Ralf
