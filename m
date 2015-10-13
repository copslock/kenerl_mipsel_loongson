Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 14:53:03 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:50661 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009746AbbJMMxAasksV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 14:53:00 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0MTtCv-1aCYVo2FkH-00Qimh; Tue, 13 Oct
 2015 14:52:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     kernel-build-reports@lists.linaro.org
Cc:     Mark Brown <broonie@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Seiji Aguchi <seiji.aguchi@hds.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mike Waychison <mikew@google.com>,
        Matt Fleming <matt.fleming@intel.com>,
        linux-mips@linux-mips.org, linaro-kernel@lists.linaro.org,
        linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: next-20151013 build: 1 failures 50 warnings (next-20151013)
Date:   Tue, 13 Oct 2015 14:52:42 +0200
Message-ID: <10774670.W40zvvZu4L@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20151013125026.GG14956@sirena.org.uk>
References: <E1ZlxDc-0000ea-U4@optimist> <20151013125026.GG14956@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:MyFGi+ERUouwPtsygrQ+Mz/dS/X6vATNtmvCiy/zQGy5d6bWjQI
 OQKRf9eZthT3cvq5bviokRgSZxdXsxmNYfTqlOvYYr7LsYhEDm/mN5g1ZtsZCCgq7xDHGv5
 /1dUSq3h19O3twLwFp53NPlgU5iDuduE5DjKA9x83nW/Y/pS2uVEC0gbsIezdPm2rNJJ+lN
 DpnHBStUWa+gBefcQAMRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FW0dbzghydU=:sLroajftzVFyv/wujLhYjO
 F8yHPvTGYzxUfDnZ8L/4WBQbQjwDwSJUTKC+ZTbxCiOf7kgTooHScXkDVXqYAejfZwQSVpW2+
 9WI1P+c0jI4RHbm8WSFwoVWHlrZxVcgq0qcOC9lC9EW5M0oMkA9BXJp8ehqk4GzKx7Aeqsqg1
 84NxSmVTbifiLjlTxz1p0CPE50mXy3h0/1Eb9KrO63sJOyuxcxC9x1fdnSgMoVzoMx8nmq1SY
 gppZrhRymYTPuXwzWasybd7G80YUV3U6hhtcvYQrErYPUa80dyI5IRLFs2OoHpVybrUutX9yu
 2PeSw+NM/LB6Avb6XyvUJ7z+EQBB1py6VgGEDIhlcDx4iJ3fBw2ONzxekpZEhfXvbzHYNgkEO
 imuEEA+eyquOo1wswf05RJ8qr3ETdAPZ2Miaugc19OIu9OnoJz3pNnrJqze+vck3TjUTro0xj
 pfxcnKRogW9kKHGoTWirt4S8LDcn9Sfe7Cj1KBZwRFtqNgRNMt7aSA4l9e+FO2ZKH6JPDBbq+
 fTehJpoEevyLJ8Nc41q3XBS5CzqIA7NGAfj5PgVyaj/tYMPOvunlUAEuCZsfeb1I+dcYmPXXX
 u8nPGfPz02zdHPxevHDV/7wBUhs7WeQh/j3k1pbm2Yzpvl6RaOwvoA14IAnH9w65cGIOGfKth
 O5bJuCjBI2heIAe1sIjUrhdE3WQctV7RslJRhKr1hK2XCJSgJa0rGtgUjstqr7tInynfzLzow
 prptneZU40NCi1oy
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49517
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

On Tuesday 13 October 2015 13:50:26 Mark Brown wrote:
> On Tue, Oct 13, 2015 at 11:54:09AM +0100, Build bot for Mark Brown wrote:
> 
> Today's linux-next fails to build an ARM allmodconfig due to:
> 
> >       arm-allmodconfig
> > ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:30: error: macro "DIV_ROUND_UP" requires 2 arguments, but only 1 given
> > ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:4: error: 'DIV_ROUND_UP' undeclared (first use in this function)
> 
> triggered by f6e734a8c16229 (MIPS: BCM47xx: Move NVRAM driver to the
> drivers/firmware/).  Presumably this works due to an implicit inclusion
> on MIPS.
> 
> I've CCed a lot of people listed in the changelog of the patch, though
> the list there appears somewhat random - apologies if this is irrelevant
> to you.

I've submitted a patch yesterday, see https://lkml.org/lkml/2015/10/12/303

	ARnd
