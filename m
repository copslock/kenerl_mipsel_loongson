Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 13:08:04 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:61671 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010759AbcA1MICvBcFO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 13:08:02 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPSA (Nemesis) id 0LlMaV-1ZqWjR10lj-00bH26; Thu, 28 Jan
 2016 13:07:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date:   Thu, 28 Jan 2016 13:07:10 +0100
Message-ID: <1889851.3PhZkL3YD7@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <3596300.IYfzmako0c@wuerfel> <20160128031435.GA25625@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:VqwUEKbCT3qgAzAhF3H9HYSfvahnjUHlcrYbIQOyAURloD+qBAF
 7Xt2UH5R8cZ225/Z1WN3DD8giSK0aTomCq7KYxcKBLZuN710XvlH5udg0IzaNhv3Kn/vSe5
 s8p99qu3i+OMuk9/nZIYEYHFesPguWuPHjlhZZjmhWv8Q9oVri/btqNz8kmlaDCLsNu4P6z
 ziDpCrk55NMs1NWOF8IRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WRobuUxhwh0=:oLWhaXtmgreXzzDJBg+8om
 rb6k5h7BqI06Hwu8zZ/EQt1fZ5t/yntHP+REYWkDJUHskW3b2KvVN9tSW8LO6UiJemAJ5Vmtn
 /gv9Xu/6sS2SXfYYCln3WBGFPUorJQiZhabyCq+fAaL11d1LeJctoP3jOYI8nfXILvW/4ApRA
 8fk9yuka9euSKJ6ODUMXOCooyj2hqvhgqZyDSxJ6oory+eZ/J5iPZK4LzahE00RVlh0fugWNP
 l79tmPb7wmR/CA9GjQe+Kk7AYs+FNHdAXRrMa5HFIB+0M/qQRpFFcCSUm9LWbqGcKKK85Bsmd
 DrdCJnhWTQD8Tz4WgEgtXo7CiuAXo7BT/Gbt1OG6oKLxOeck/5PdHQPOWnzPXaz3OpdW7/jsM
 +O98RC4t15pOi6OudxUAR/SnwBQclPL7ZlASEXgIKKGmWBjwMzPfrMtjmbzTPwni/7mPZX3iD
 e6AYgh9qwDf1d64UC6wRlupi0bafxSdtsXhdvzDOFI9N/AUBepd5Ed7DOtgVizmKNaZuOvoje
 ZBm1Y7Fsf+8UPVaqlxbvQW4RPdJDgB/2gNqR+yhRHVyYJV6X5xkbReqIPhy7Azo03XGMXFFLM
 Bws6/Mi1Qt4cAY3nYineRHPzcnrOPSXiMeq0I11Qz17dkzkCGhK9d5eDUdL1KZFTQ0ueHym9A
 41peLxyc1oyQ3pEIcMdBSeGjokoMU4JCJIg/CcfJlAS6OhoxilTs/EqnQroyAM24YEFSM+UxO
 S3wq9Hgf+N49UFrM
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51509
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

On Thursday 28 January 2016 11:14:35 Fengguang Wu wrote:

> > - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
> >   in 'make config'
> 
> That's a problem for auto tests.

Ok, I'll try to revisit this one. Maybe I can turn it into a
'default 0xffffffff' with a compile-time warning, or make
'default 0' the fallback when it's not specified otherwise.

	Arnd
