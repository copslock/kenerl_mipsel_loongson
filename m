Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 15:49:01 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.73]:63027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028609AbcEMNtAIMQ7z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 15:49:00 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0MORwj-1avQZ213TB-005mLl; Fri, 13 May
 2016 15:48:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     John Youn <John.Youn@synopsys.com>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Felipe Balbi <balbi@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date:   Fri, 13 May 2016 15:48:14 +0200
Message-ID: <5706100.G8QoS78uJd@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <573574F2.8010901@synopsys.com>
References: <1463086588-2393828-1-git-send-email-arnd@arndb.de> <573574F2.8010901@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:yIv14ijM96Q0fNlMp2Nc2ik6e8rZcmhFCs+iWnZLLewA9OZ50kx
 EyKVdT/MnABn740eGdxk/VW0WsKEc/7kKv1R3p9uxScU7GTCyIQjikTVfIeackxcC7rrJXL
 D0jlEx5wx079dudpevQqo4Elejmmy033YagS9STNQ3Wi+Iq9DjSzmjqhTAI2VbGFJGkm15P
 mVs8sNXS4aNSuhYvKDOAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:03wtSxP2/oI=:nt5CmDIOk7xMHrDpbqe2Fx
 sN82jwvgTrp/9olJ18F6JgpvT/FvavpWAy0FMldQCAcZhQCyfgu/N91+kHY91Kn91U0REHho+
 NQoj+TUc4QdBnDj/VQ7+L5EzNu9+WUMyF2XKVlPK/Jl9/0AmgGuWRa4fZAC7bZyiZoO0Wt3sG
 Nx86t5kMp/Ev8HFF0B2MRzzE54nhtiMCp1YizbbiIlfiTG1B60a1vUB+sIQ8rMI8ZuMuW7OdD
 qnLGtotu3o/78xeV8DawS6/2hK9Is+/ycZblxTRq1NAwIkKRidt5vGBuO/YJ6r37bfagCfQqo
 u/9TxSX4vSJT1hhzetD1QRbDc3BOhg+7ajueBiksD5a5LysIV8TX0hCNMEBaRCyRW3kVB9NIN
 GPU4hkT7K06lMVB9bdqzI/NiHr6EzxKo/XNOxddJE2ic4xeAtWLxFK79VpHoUGvSnax9bXC4D
 Fh1JR4ECeRP1VgAG22EeLwxXYNU2TmS2jiRDLZhY/Rn3ocABokAIQxfiEG2A/VRY5DhdZYdBr
 BVTrK5OoRFAQgIziQQDYmnXXAdfE1EPCKiosytDhTJ00cYoV14WbAEnIAOAb5wVHF9aZJw1ot
 llTkoi5DePBlzK8+1UKeIg9oMsZ2elH1acEI49P5B4vyQhVUx5UfTeSSCDEGzsNT0/qub0vgS
 iKEQgu2q1Q29fLswXsgNQP8fnucKK0ZZdBW4zrUF4nFe5/Cc05Wfv3fzi5V5dri4nntc+hUc2
 CtkX8g7oq0WDQIMM
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53437
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

On Thursday 12 May 2016 23:32:18 John Youn wrote:
> 
> Hi Arnd,
> 
> The capitalization issue is still there in this patch.
> 
> There's also a few checkpatch issues.

Fixed now, thanks. I'll send a v4 in a bit.

> And should the barrier be moved after the write like it says in the
> comment? That seems to have been removed since earlier versions of
> the patch.

I've clarified the comment, so we refer to the __raw_writel
not the writel. It's also possible that this was just another
bug in the patch that broke powerpc, but I don't know anything
about MIPS barrier semantics, so I prefer not to touch that.

	Arnd
