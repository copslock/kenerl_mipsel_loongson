Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 09:15:27 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:52525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006864AbbBXIPZtL2MG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 09:15:25 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0Lm4KP-1XrNvU3ODJ-00Zi86; Tue, 24 Feb
 2015 09:15:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/5] MIPS: Allow platforms to specify the decompressor load address
Date:   Tue, 24 Feb 2015 09:15:12 +0100
Message-ID: <7814815.Q6KYv1fjo1@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1424741507-8882-3-git-send-email-abrestic@chromium.org>
References: <1424741507-8882-1-git-send-email-abrestic@chromium.org> <1424741507-8882-3-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:FHWAKy57W4xmqHcTnqIsQBR/4vEjGjMvE4ppJew020ddZ5Kgkgv
 Ms428txqMn8nayti3gYo/AQ0CbebW+yLBPlILtszr37u3abS/sEC5Qtm2GNZbcMZXM16EDD
 l0qnrv10vOPqM8+rz1O6A5Tof9W1goRycHYblOSS7GtHkWbwecvAs9LGTRsqi02vxvL5+Vj
 Sl5h+fOXUkWO4uK/ezkPw==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 23 February 2015 17:31:44 Andrew Bresticker wrote:
> Platforms which use raw zboot images may need to link the image at
> a fixed address if there is no other way to communicate the load
> address to the bootloader.  Allow the per-platform Kbuild files
> to specify an optional zboot image load address (zload-y) and fall
> back to calc_vmlinuz_load_addr if unset.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

No objections to the patch, but have you considered doing the
same thing as ARM's AUTO_ZRELADDR, where we calculate the
address at runtime from the entry point?

I assume this is the same kind of address you are talking
about here; if not, nevermind.

	Arnd
