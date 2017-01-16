Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 14:34:23 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:42731 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991932AbdAPNeMgFOcv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2017 14:34:12 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8443AC27;
        Mon, 16 Jan 2017 13:34:11 +0000 (UTC)
Date:   Mon, 16 Jan 2017 14:34:11 +0100
Message-ID: <s5h60lfxh64.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Jaroslav Kysela" <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ALSA: mips: avoid potential uninitialized variable use
In-Reply-To: <20170116132805.2207208-1-arnd@arndb.de>
References: <20170116132805.2207208-1-arnd@arndb.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.1
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
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

On Mon, 16 Jan 2017 14:27:57 +0100,
Arnd Bergmann wrote:
> 
> MIPS allmodconfig results in this warning:
> 
> sound/mips/hal2.c: In function 'hal2_gain_get':
> sound/mips/hal2.c:224:35: error: 'r' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> sound/mips/hal2.c:223:35: error: 'l' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> sound/mips/hal2.c: In function 'hal2_gain_put':
> sound/mips/hal2.c:260:13: error: 'new' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> sound/mips/hal2.c:260:13: error: 'old' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Returning an error for all unexpected cases shuts up the warning
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: actually send the correct patch, sorry for the mixup
> v2: return an error instead trying to handle gracefully

Thanks, applied now.


Takashi
