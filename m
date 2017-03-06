Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 21:06:36 +0100 (CET)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:51064 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992155AbdCFUG243lOU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 21:06:28 +0100
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v26K1JNJ027336;
        Mon, 6 Mar 2017 14:06:21 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2918j6hemm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2017 14:06:21 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod3.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v26K6KSR017836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2017 14:06:20 -0600
Received: from us-aus-exch7.ni.corp.natinst.com (130.164.68.17) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 6 Mar 2017 14:06:20 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch7.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 6 Mar 2017 14:06:20 -0600
Received: from nathan3500-linux-VM.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Mon, 6 Mar 2017 14:06:20 -0600
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     <linus.walleij@linaro.org>, <gnurou@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v2] MIPS: NI 169445 board support
Date:   Mon, 6 Mar 2017 14:05:59 -0600
Message-ID: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-06_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703060160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-06_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=30 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.0.1-1702020001 definitions=main-1703060160
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57056
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

This adds support for the National Instruments 169445 MIPS system.

----

Changes from v1:

- Add GPIO patch and board support patch to one set
- Address Rob Herring's device tree feedback
- Convert the 169445 to a generic MIPS board
- Switch to the newer stmmac driver for the board's ethernet core
