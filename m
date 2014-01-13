Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 19:26:36 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:44191 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6867245AbaAMS0eGYNGa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jan 2014 19:26:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id E1C4519BF40;
        Mon, 13 Jan 2014 20:26:30 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id QuWmQZvYQUCr; Mon, 13 Jan 2014 20:26:26 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with SMTP id B0D455BC011;
        Mon, 13 Jan 2014 20:26:25 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Mon, 13 Jan 2014 20:26:15 +0200
Date:   Mon, 13 Jan 2014 20:26:15 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [3.13-rc regression] Unbreak Loongson2 and r4k-generic flush
 icache range
Message-ID: <20140113182615.GC24795@blackmetal.musicnaut.iki.fi>
References: <ord2jwnmwd.fsf@livre.home>
 <52D3EA9B.6020404@cogentembedded.com>
 <52D3ED11.1080103@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52D3ED11.1080103@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Jan 13, 2014 at 02:41:37PM +0100, John Crispin wrote:
> On 13/01/14 14:31, Sergei Shtylyov wrote:
> >On 13-01-2014 15:26, Alexandre Oliva wrote:
> >>Commit 14bd8c08, that replaced Loongson2-specific ifdefs with cpu tests,
> >
> >Fix for this issue has been posted long ago:
> >
> >http://marc.info/?l=linux-mips&m=138575576803890
> 
> i was under the impression that it is in rc8 but i am failing to see
> it there.

The patches are currently in -mm tree, and hopefully will be in the
final 3.13.

A.
