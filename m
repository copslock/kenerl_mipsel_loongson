Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 12:35:16 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992408AbeISKfMWxPub (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 12:35:12 +0200
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JAXooc055878
        for <linux-mips@linux-mips.org>; Wed, 19 Sep 2018 06:35:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mkkaxv2y9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Wed, 19 Sep 2018 06:35:10 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 19 Sep 2018 11:35:08 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Sep 2018 11:35:02 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8JAZ1bS55509114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Sep 2018 10:35:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CE63A4051;
        Wed, 19 Sep 2018 13:34:46 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB092A404D;
        Wed, 19 Sep 2018 13:34:44 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.135])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Sep 2018 13:34:44 +0100 (BST)
Date:   Wed, 19 Sep 2018 13:34:57 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 03/29] mm: remove CONFIG_HAVE_MEMBLOCK
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
 <20180919100449.00006df9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919100449.00006df9@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18091910-0028-0000-0000-000002FB7231
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091910-0029-0000-0000-000023B52DB5
Message-Id: <20180919103457.GA20545@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190110
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

Hi Jonathan,

On Wed, Sep 19, 2018 at 10:04:49AM +0100, Jonathan Cameron wrote:
> On Wed, 5 Sep 2018 18:59:18 +0300
> Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > All architecures use memblock for early memory management. There is no need
> > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Hi Mike,
> 
> A minor editing issue in here that is stopping boot on arm64 platforms with latest
> version of the mm tree.

Can you please try the following patch:
