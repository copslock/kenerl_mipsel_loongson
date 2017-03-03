Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2017 15:09:13 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35375 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993418AbdCCOJFlLr7L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Mar 2017 15:09:05 +0100
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v23E4ASZ055993
        for <linux-mips@linux-mips.org>; Fri, 3 Mar 2017 09:09:02 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8et4fr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 03 Mar 2017 09:09:02 -0500
Received: from localhost
        by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <heiko.carstens@de.ibm.com>;
        Fri, 3 Mar 2017 14:08:52 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp09.uk.ibm.com (192.168.101.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 3 Mar 2017 14:08:40 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id F1B3C2190023;
        Fri,  3 Mar 2017 14:07:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v23E8ewe2163016;
        Fri, 3 Mar 2017 14:08:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6765B4C04E;
        Fri,  3 Mar 2017 14:08:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D0E4C044;
        Fri,  3 Mar 2017 14:08:37 +0000 (GMT)
Received: from osiris (unknown [9.152.212.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Mar 2017 14:08:37 +0000 (GMT)
Date:   Fri, 3 Mar 2017 15:08:37 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/3] futex: remove duplicated code
References: <20170303122712.13353-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 17030314-0036-0000-0000-0000037974A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17030314-0037-0000-0000-00001551A0F9
Message-Id: <20170303140837.GF5319@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-03_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703030134
Return-Path: <heiko.carstens@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko.carstens@de.ibm.com
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

On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
> 
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
> 
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  arch/s390/include/asm/futex.h       | 23 ++++-------------
>  include/asm-generic/futex.h         | 50 +++++++------------------------------
>  kernel/futex.c                      | 36 ++++++++++++++++++++++++++

Looks good to me and still boots on s390. Therefore for the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks!
