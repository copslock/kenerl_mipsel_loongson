Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 15:58:33 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:20172 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992334AbdKNO60exKnG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 15:58:26 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id vAEEqaGh001275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2017 14:52:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id vAEEqajP014538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2017 14:52:36 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id vAEEqS6C014995;
        Tue, 14 Nov 2017 14:52:30 GMT
Received: from concerto (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Nov 2017 06:52:27 -0800
Message-ID: <1510671145.4344.1.camel@oracle.com>
Subject: Re: linux-next: Tree for Nov 7
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Date:   Tue, 14 Nov 2017 07:52:25 -0700
In-Reply-To: <20171114090444.lhrkuywuls26g6lu@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au>
         <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
         <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
         <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
         <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
         <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
         <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
         <87lgjawgx1.fsf@concordia.ellerman.id.au>
         <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
         <87h8txw87w.fsf@concordia.ellerman.id.au>
         <20171114090444.lhrkuywuls26g6lu@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <khalid.aziz@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khalid.aziz@oracle.com
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

On Tue, 2017-11-14 at 10:04 +0100, Michal Hocko wrote:
> If there is a general consensus that this is the preferred way to go,
> I
> will post the patch as an RFC to linux-api
> 
> [1] http://lkml.kernel.org/r/20171113160637.jhekbdyfpccme3be@dhcp22.s
> use.cz

I prefer the new flag. It is cleaner and avoids unintended breakage for
existing flag.

--
Khalid
