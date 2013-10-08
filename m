Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 00:51:30 +0200 (CEST)
Received: from mx0b-0016ce01.pphosted.com ([67.231.156.153]:58556 "EHLO
        mx0b-0016ce01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832660Ab3JHWv1Ny1lQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 00:51:27 +0200
Received: from pps.filterd (m0000643.ppops.net [127.0.0.1])
        by mx0b-0016ce01.pphosted.com (8.14.5/8.14.5) with SMTP id r98MlqQh028058;
        Tue, 8 Oct 2013 15:47:52 -0700
Received: from avcashub1.qlogic.com (avcashub2.qlogic.com [198.70.193.116])
        by mx0b-0016ce01.pphosted.com with ESMTP id 1f9y9gexwe-2
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 08 Oct 2013 15:47:52 -0700
Received: from AVMB3.qlogic.org ([fe80::689d:1159:4632:e0eb]) by
 avcashub2.qlogic.org ([::1]) with mapi id 14.02.0318.001; Tue, 8 Oct 2013
 15:46:52 -0700
From:   Himanshu Madhani <himanshu.madhani@qlogic.com>
To:     Alexander Gordeev <agordeev@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Ingo Molnar" <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "e1000-devel@lists.sourceforge.net" 
        <e1000-devel@lists.sourceforge.net>,
        Dept-Eng Linux Driver <Linux-Driver@qlogic.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts
 enablement code
Thread-Topic: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts
 enablement code
Thread-Index: AQHOv5RcqYUscGmM3UKDp5I4ucW3w5nr5r5g
Date:   Tue, 8 Oct 2013 22:46:51 +0000
Message-ID: <ADFE82A996F10145934E45547759F7638C923C26@avmb3.qlogic.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <c92efbde96541d08f37510422c096d543bb01279.1380703263.git.agordeev@redhat.com>
In-Reply-To: <c92efbde96541d08f37510422c096d543bb01279.1380703263.git.agordeev@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.4.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5600 definitions=7222 signatures=668739
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=7.0.1-1305240000 definitions=main-1310080131
Return-Path: <himanshu.madhani@qlogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: himanshu.madhani@qlogic.com
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

> -----Original Message-----
> From: Alexander Gordeev [mailto:agordeev@redhat.com]
> Sent: Wednesday, October 02, 2013 3:49 AM
> To: linux-kernel
> Cc: Alexander Gordeev; Bjorn Helgaas; Ralf Baechle; Michael Ellerman;
> Benjamin Herrenschmidt; Martin Schwidefsky; Ingo Molnar; Tejun Heo; Dan
> Williams; Andy King; Jon Mason; Matt Porter; linux-pci; linux-mips@linux-
> mips.org; linuxppc-dev@lists.ozlabs.org; linux390@de.ibm.com; linux-
> s390@vger.kernel.org; x86@kernel.org; linux-ide@vger.kernel.org;
> iss_storagedev@hp.com; linux-nvme@lists.infradead.org; linux-
> rdma@vger.kernel.org; netdev; e1000-devel@lists.sourceforge.net; Dept-
> Eng Linux Driver; Solarflare linux maintainers; VMware, Inc.; linux-scsi
> Subject: [PATCH RFC 63/77] qlcnic: Update MSI/MSI-X interrupts enablement
> code
> 
> As result of recent re-design of the MSI/MSI-X interrupts enabling pattern
> this driver has to be updated to use the new technique to obtain a optimal
> number of MSI/MSI-X interrupts required.
> 
 "We will test this change for the driver and provide feedback."

> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Thanks,
Himanshu
