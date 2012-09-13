Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2012 10:27:01 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55415 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903354Ab2IMI0y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Sep 2012 10:26:54 +0200
Message-ID: <50519848.6050901@openwrt.org>
Date:   Thu, 13 Sep 2012 10:24:40 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
MIME-Version: 1.0
To:     akpm@linux-foundation.org
CC:     richard -rw- weinberger <richard.weinberger@gmail.com>,
        Tracey Dent <tdent48227@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/1] Arch: mips: Delete Makefile.rej
References: <1347490239-1351-1-git-send-email-tdent48227@gmail.com> <CAFLxGvxL+2PG-MvNQTQ8a7hKaC3TBZutEBAPETDb_pkMwBSbZQ@mail.gmail.com>
In-Reply-To: <CAFLxGvxL+2PG-MvNQTQ8a7hKaC3TBZutEBAPETDb_pkMwBSbZQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 13/09/12 01:15, richard -rw- weinberger wrote:
> On Thu, Sep 13, 2012 at 12:50 AM, Tracey Dent<tdent48227@gmail.com>  wrote:
>> Makefile.rej should not be there. That was introduced
>> in commit 3fa68afc3d774bab1e91cbb3a3cdd1e36068ee95 .
> Linus' tree does not contain such a commit id.
>

Hi,

my bad .. its in linux-next (3fa68afc3d774bab1e91cbb3a3cdd1e36068ee95)  
and comes from the upstream-sfr tree on linux-mips.org

i will talk to Ralf and fix it inside the lmo tree.

Thanks,
John
