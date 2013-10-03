Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 19:46:14 +0200 (CEST)
Received: from mx0a-0016ce01.pphosted.com ([67.231.148.157]:38160 "EHLO
        mx0a-0016ce01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865174Ab3JCRqME-V9P convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Oct 2013 19:46:12 +0200
Received: from pps.filterd (m0045602.ppops.net [127.0.0.1])
        by mx0a-0016ce01.pphosted.com (8.14.5/8.14.5) with SMTP id r93HRWbL032706;
        Thu, 3 Oct 2013 10:42:36 -0700
Received: from avcashub1.qlogic.com (avcashub2.qlogic.com [198.70.193.116])
        by mx0a-0016ce01.pphosted.com with ESMTP id 1f91vb930v-2
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 03 Oct 2013 10:42:36 -0700
Received: from AVMB1.qlogic.org ([fe80::c919:8cc:f3ba:c727]) by
 avcashub2.qlogic.org ([::1]) with mapi id 14.02.0318.001; Thu, 3 Oct 2013
 10:42:34 -0700
From:   Saurav Kashyap <saurav.kashyap@qlogic.com>
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
Subject: Re: [PATCH RFC 59/77] qla2xxx: Update MSI/MSI-X interrupts
 enablement code
Thread-Topic: [PATCH RFC 59/77] qla2xxx: Update MSI/MSI-X interrupts
 enablement code
Thread-Index: AQHOwF/w5pjxosepm0ec17m9dR0hkA==
Date:   Thu, 3 Oct 2013 17:42:33 +0000
Message-ID: <F5D084D6342F9B479C34599BB0A03E4D8982E209@AVMB1.qlogic.org>
In-Reply-To: <54f6b89372f51cd27a6adf6ecc91b8bf6bb5ba74.1380703263.git.agordeev@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.10.0.110310
x-originating-ip: [10.1.4.10]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7ECF417E2B641E48ADC3CD2AEF525292@qlogic.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5600 definitions=7216 signatures=668722
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=7.0.1-1305240000 definitions=main-1310030074
Return-Path: <saurav.kashyap@qlogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: saurav.kashyap@qlogic.com
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

Acked-by: Saurav Kashyap <saurav.kashyap@qlogic.com>


>As result of recent re-design of the MSI/MSI-X interrupts enabling
>pattern this driver has to be updated to use the new technique to
>obtain a optimal number of MSI/MSI-X interrupts required.
>
>Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
>---
> drivers/scsi/qla2xxx/qla_isr.c |   18 +++++++++++-------
> 1 files changed, 11 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/scsi/qla2xxx/qla_isr.c
>b/drivers/scsi/qla2xxx/qla_isr.c
>index df1b30b..6c11ab9 100644
>--- a/drivers/scsi/qla2xxx/qla_isr.c
>+++ b/drivers/scsi/qla2xxx/qla_isr.c
>@@ -2836,16 +2836,20 @@ qla24xx_enable_msix(struct qla_hw_data *ha,
>struct rsp_que *rsp)
> 	for (i = 0; i < ha->msix_count; i++)
> 		entries[i].entry = i;
> 
>-	ret = pci_enable_msix(ha->pdev, entries, ha->msix_count);
>-	if (ret) {
>+	ret = pci_msix_table_size(ha->pdev);
>+	if (ret < 0) {
>+		goto msix_failed;
>+	} else {
> 		if (ret < MIN_MSIX_COUNT)
> 			goto msix_failed;
> 
>-		ql_log(ql_log_warn, vha, 0x00c6,
>-		    "MSI-X: Failed to enable support "
>-		    "-- %d/%d\n Retry with %d vectors.\n",
>-		    ha->msix_count, ret, ret);
>-		ha->msix_count = ret;
>+		if (ret < ha->msix_count) {
>+			ql_log(ql_log_warn, vha, 0x00c6,
>+			    "MSI-X: Failed to enable support "
>+			    "-- %d/%d\n Retry with %d vectors.\n",
>+			    ha->msix_count, ret, ret);
>+			ha->msix_count = ret;
>+		}
> 		ret = pci_enable_msix(ha->pdev, entries, ha->msix_count);
> 		if (ret) {
> msix_failed:
>-- 
>1.7.7.6
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
