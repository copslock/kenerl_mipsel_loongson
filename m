Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 19:42:53 +0100 (CET)
Received: from linux-libre.fsfla.org ([208.118.235.54]:34279 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010054AbcAGSmt1jGjM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 19:42:49 +0100
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id u07Igi24019711;
        Thu, 7 Jan 2016 18:42:45 GMT
Received: from livre.home (livre.home [172.31.160.2])
        by freie.home (8.15.2/8.15.2) with ESMTP id u07IgOsl003978;
        Thu, 7 Jan 2016 16:42:24 -0200
From:   Alexandre Oliva <oliva@gnu.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] ld-version: fix it on Fedora
Organization: Free thinker, not speaking for the GNU Project
References: <1452189189-31188-1-git-send-email-mst@redhat.com>
Date:   Thu, 07 Jan 2016 16:42:24 -0200
In-Reply-To: <1452189189-31188-1-git-send-email-mst@redhat.com> (Michael
        S. Tsirkin's message of "Thu, 7 Jan 2016 19:55:24 +0200")
Message-ID: <ormvsh44fj.fsf@livre.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <oliva@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliva@gnu.org
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

On Jan  7, 2016, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fedora 23, ld --version outputs:
> GNU ld version 2.25-15.fc23

> But ld-version.sh fails to parse this

On gnewsense 3, ld --version outputs:

GNU ld (GNU Binutils for Debian) 2.20.1-system.20100303
Copyright [...]

The date at the end severely confuses the version parser.

Furthermore, awk is mawk, whose gsub takes ')' as grouping, so it
complains about the missing '('.

Also, once a[1] is multiplied by 1e7, mawk's print spits out the number
in exponential notation, which confuses the -lt test.  In order to avoid
that falling back to floating-point numbers, I've used smaller
multipliers and concatenated (truncated) integers.  Yuck.

I've modified the script so that it takes the - as a separator too, and
so that it works on both gawk and mawk.  Here's the ld-version.sh that
worked for me.  I guess this will have to be combined with your patch
somehow.

#!/usr/bin/awk -f
# extract linker version number from stdin and turn into single number
        {
        gsub(".*[)]", "");
        split($1,a, "[-.]");
        printf "%i%04i\n", a[1]*10000 + a[2]*100 + a[3], (a[4]*100 + a[5])%10000;
        exit
        }

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
