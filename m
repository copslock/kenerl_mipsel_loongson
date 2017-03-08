Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 20:36:21 +0100 (CET)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:41665 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992178AbdCHTgPTUtiF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 20:36:15 +0100
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v28JVrmG028345;
        Wed, 8 Mar 2017 13:36:03 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 292kja9890-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2017 13:36:02 -0600
Received: from us-aus-exch2.ni.corp.natinst.com (us-aus-exch2.ni.corp.natinst.com [130.164.68.12])
        by us-aus-skprod2.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v28Ja1HF009971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2017 13:36:01 -0600
Received: from us-aus-exch4.ni.corp.natinst.com (130.164.68.14) by
 us-aus-exch2.ni.corp.natinst.com (130.164.68.12) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 8 Mar 2017 13:36:01 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch4.ni.corp.natinst.com (130.164.68.14) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 8 Mar 2017 13:36:01 -0600
Received: from nathan3500-linux-VM.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Wed, 8 Mar 2017 13:36:01 -0600
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     <linus.walleij@linaro.org>, <gnurou@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v3] NI 169445 board support
Date:   Wed, 8 Mar 2017 13:35:42 -0600
Message-ID: <1489001744-26545-1-git-send-email-nathan.sullivan@ni.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-08_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703080152
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-08_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=30 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.0.1-1702020001 definitions=main-1703080152
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan.sullivan@ni.com
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

Add support for the National Instruments 169445 board

----
Changes from v2:

- Hand write the board config fragment, and make it more minimal.
- Add myself as the maintainer of new dirs and files.
