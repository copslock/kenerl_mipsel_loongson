Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 09:10:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48389 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903672Ab2FTHKK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 09:10:10 +0200
Message-ID: <4FE1771A.8070703@phrozen.org>
Date:   Wed, 20 Jun 2012 09:09:14 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Yoichi Yuasa <yuasa@linux-mips.org>
CC:     linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com> <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 20/06/12 08:27, Yoichi Yuasa wrote:
> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
> 

Hi Yoichi,

I stumbled across the same build regression last night and came up with
almost the same fix :-)

Tested-by: John Crispin <blogic@openwrt.org>

Thanks,
John
