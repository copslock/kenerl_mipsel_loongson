Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2018 14:37:43 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991162AbeKBNhkS1Ybi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2018 14:37:40 +0100
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2DXrl5013056
        for <linux-mips@linux-mips.org>; Fri, 2 Nov 2018 09:37:38 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ngmj1ftu6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 02 Nov 2018 09:37:38 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 13:37:36 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 13:37:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2DbSIP38338648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 13:37:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74EE8B205F;
        Fri,  2 Nov 2018 13:37:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D013B2068;
        Fri,  2 Nov 2018 13:37:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.108])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 13:37:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 64F6A16C36E4; Fri,  2 Nov 2018 06:37:28 -0700 (PDT)
Date:   Fri, 2 Nov 2018 06:37:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Reply-To: paulmck@linux.ibm.com
References: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <20181101170146.GQ4170@linux.ibm.com>
 <7d1ecd21c4c249138dfdd42b9aaa1cea@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1ecd21c4c249138dfdd42b9aaa1cea@AcuMS.aculab.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110213-0072-0000-0000-000003C17830
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009972; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111590; UDB=6.00576070; IPR=6.00891681;
 MB=3.00024005; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 13:37:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110213-0073-0000-0000-000049F921A3
Message-Id: <20181102133728.GR4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=1
 clxscore=1015 lowpriorityscore=0 mlxscore=1 impostorscore=0
 mlxlogscore=225 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020124
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.ibm.com
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

On Fri, Nov 02, 2018 at 10:56:31AM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 01 November 2018 17:02
> ...
> > And there is a push to define C++ signed arithmetic as 2s complement,
> > but there are still 1s complement systems with C compilers.  Just not
> > C++ compilers.  Legacy...
> 
> Hmmm... I've used C compilers for DSPs where signed integer arithmetic
> used the 'data registers' and would saturate, unsigned used the 'address
> registers' and wrapped.
> That was deliberate because it is much better to clip analogue values.

There are no C++ compilers for those DSPs, correct?  (Some of the
C++ standards commmittee members believe that they have fully checked,
but they might well have missed something.)

> Then there was the annoying cobol run time that didn't update the
> result variable if the result wouldn't fit.
> Took a while to notice that the sum of a list of values was even wrong!
> That would be perfectly valid for C - if unexpected.

Heh!  COBOL and FORTRAN also helped fund my first pass through university.

> > > But for us using -fno-strict-overflow which actually defines signed
> > > overflow
> 
> I wonder how much real code 'strict-overflow' gets rid of?
> IIRC gcc silently turns loops like:
> 	int i; for (i = 1; i != 0; i *= 2) ...
> into infinite ones.
> Which is never what is required.

The usual response is something like this:

	for (i = 1; i < n; i++)

where the compiler has no idea what range of values "n" might take on.
Can't say that I am convinced by that example, but at least we do have
-fno-strict-overflow.

							Thanx, Paul
