Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 20:40:00 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:51657 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902756Ab2HNSjw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 20:39:52 +0200
Received: from klappe2.localnet (HSI-KBW-149-172-5-253.hsi13.kabel-badenwuerttemberg.de [149.172.5.253])
        by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
        id 0Mc8Nr-1TJqcR2WO7-00J9DP; Tue, 14 Aug 2012 20:39:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 0/2] Align MIPS swapper_pg_dir for faster code.
Date:   Tue, 14 Aug 2012 18:39:41 +0000
User-Agent: KMail/1.12.2 (Linux/3.5.0; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
References: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208141839.41441.arnd@arndb.de>
X-Provags-ID: V02:K0:i21pUrDBuA6vgW6GO8ZWM1ouWOKa4IeboWcf3hAMtAd
 OmAMrR12HTamt1WW5Hhh43SeC9JPiMf62FUKyvCHwFgAOR2wS6
 mvl108NOgoTwZjnGUb/LMSJX55MRiRdlYv4CQxYkiIEHByeDG4
 gnvrtz6VAmId8jM3OXElM1rdRMiksNqYfEL+0Pe1A4hf4H/UXZ
 6HLP0olEmOrPRYD63wFSqigEWUqGUdyjGvAbhW8hV0/YtlisTo
 y44X1jRen0oGHYBslNM1i/K8ENfykwOPaUu+64J+0SzIvL7sw6
 btBy5RzRQB5c/7EVsBmId8jcWlhra6xiZSAAe4dXX6byB9e7OS
 DQ5VSZAk1EJZyOGd+iSQ=
X-archive-position: 34168
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tuesday 14 August 2012, David Daney wrote:
> Since the initial use of the code is for MIPS, perhaps both parts
> could be merged by Ralf's tree (after collecting any Acked-bys).

Acked-by: Arnd Bergmann <arnd@arndb.de>
