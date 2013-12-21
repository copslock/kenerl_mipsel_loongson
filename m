Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 20:11:07 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:37876 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815753Ab3LUTLFVkGwo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Dec 2013 20:11:05 +0100
Message-ID: <52B5E746.4080009@phrozen.org>
Date:   Sat, 21 Dec 2013 20:08:54 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: bcm63xx: cpu: Replace BUG() with panic()
References: <1380530280-6467-1-git-send-email-markos.chandras@imgtec.com> <CAOiHx=kBLNAKhfa_6iPC5CsqYcNBCpaLPTw2ihNr8EEYdCkWsg@mail.gmail.com>
In-Reply-To: <CAOiHx=kBLNAKhfa_6iPC5CsqYcNBCpaLPTw2ihNr8EEYdCkWsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38795
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

On 21/12/13 20:08, Jonas Gorski wrote:
> The cpu_id is in hex, so it needs to be %04x - not that it matters
> much since early printk won't work yet at this stage anyway IIRC.
>
> with this fixed (maybe John is nice enough to replace the one character;),
>
> Acked-by: Jonas Gorski<jogo@openwrt.org>

i'll fold the nitpick while merging

	John
