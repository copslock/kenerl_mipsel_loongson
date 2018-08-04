Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2018 16:17:40 +0200 (CEST)
Received: from userp2120.oracle.com ([156.151.31.85]:45554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992279AbeHDORhtT8FQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Aug 2018 16:17:37 +0200
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w74EG2Fo038648;
        Sat, 4 Aug 2018 14:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=pNjcorHCBWeOfGkVYLZJyAB3n2Tx3jiexKGmlorbo/E=;
 b=p7PJddPN7Zn0HsnqvzGnwFl0ajJpkb9hBZzs3Gg+umDJ1qCMexk/6bZy389NvljncgCS
 EvSfeh6q8Q5F/9MZ/7KdfY8nL9//Ceuxmjc2by1DMCkzH7+AIDKq3Yd0WbAho/yCRER3
 miaOHEYVdKJCbm7im3m9QlxaYLvG2xes2Pdl6ZGcs1uIoE/6q24JIPBqulw3TGa+39S+
 7R5x5s9vRSqxM+3X+kstycAmGer6lpqJQvITksxyuUsPndLJ7UIKrZkrxxYGqyEHOxx1
 EB3brIJ1uNGtXVyAj18mYYhh8r6KjrveZ/4YLf4u5TWSKxKwSRdV/BbtG3d5kRuXG2SO DQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kn4spgugs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Aug 2018 14:17:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w74EHS4W023787
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Aug 2018 14:17:28 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w74EHPK6005036;
        Sat, 4 Aug 2018 14:17:28 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Aug 2018 07:17:25 -0700
Date:   Sat, 4 Aug 2018 17:17:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mschiffer@universe-factory.net
Cc:     linux-mips@linux-mips.org
Subject: [bug report] MIPS: ath79: add support for QCA953x QCA956x TP9343
Message-ID: <20180804141719.elgpuoj2m4qwdzkm@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8974 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=439
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808040157
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

Hello Matthias Schiffer,

The patch af2d1b521bfb: "MIPS: ath79: add support for QCA953x QCA956x
TP9343" from Jul 20, 2018, leads to the following static checker
warning:

	arch/mips/ath79/clock.c:570 qca956x_clocks_init()
	warn: mask and shift to zero

	arch/mips/ath79/clock.c:588 qca956x_clocks_init()
	warn: mask and shift to zero


arch/mips/ath79/clock.c
   554          pll = ath79_pll_rr(QCA956X_PLL_CPU_CONFIG_REG);
   555          out_div = (pll >> QCA956X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
   556                    QCA956X_PLL_CPU_CONFIG_OUTDIV_MASK;
   557          ref_div = (pll >> QCA956X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
   558                    QCA956X_PLL_CPU_CONFIG_REFDIV_MASK;
   559  
   560          pll = ath79_pll_rr(QCA956X_PLL_CPU_CONFIG1_REG);
   561          nint = (pll >> QCA956X_PLL_CPU_CONFIG1_NINT_SHIFT) &
   562                 QCA956X_PLL_CPU_CONFIG1_NINT_MASK;
   563          hfrac = (pll >> QCA956X_PLL_CPU_CONFIG1_NFRAC_H_SHIFT) &
   564                 QCA956X_PLL_CPU_CONFIG1_NFRAC_H_MASK;
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is 0x1fff

   565          lfrac = (pll >> QCA956X_PLL_CPU_CONFIG1_NFRAC_L_SHIFT) &
   566                 QCA956X_PLL_CPU_CONFIG1_NFRAC_L_MASK;
   567  
   568          cpu_pll = nint * ref_rate / ref_div;
   569          cpu_pll += (lfrac * ref_rate) / ((ref_div * 25) << 13);
   570          cpu_pll += (hfrac >> 13) * ref_rate / ref_div;
                            ^^^^^^^^^^^
But 0x1fff >> 13 is zero.

   571          cpu_pll /= (1 << out_div);
   572  
   573          pll = ath79_pll_rr(QCA956X_PLL_DDR_CONFIG_REG);
   574          out_div = (pll >> QCA956X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
   575                    QCA956X_PLL_DDR_CONFIG_OUTDIV_MASK;
   576          ref_div = (pll >> QCA956X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
   577                    QCA956X_PLL_DDR_CONFIG_REFDIV_MASK;
   578          pll = ath79_pll_rr(QCA956X_PLL_DDR_CONFIG1_REG);
   579          nint = (pll >> QCA956X_PLL_DDR_CONFIG1_NINT_SHIFT) &
   580                 QCA956X_PLL_DDR_CONFIG1_NINT_MASK;
   581          hfrac = (pll >> QCA956X_PLL_DDR_CONFIG1_NFRAC_H_SHIFT) &
   582                 QCA956X_PLL_DDR_CONFIG1_NFRAC_H_MASK;
   583          lfrac = (pll >> QCA956X_PLL_DDR_CONFIG1_NFRAC_L_SHIFT) &
   584                 QCA956X_PLL_DDR_CONFIG1_NFRAC_L_MASK;
   585  
   586          ddr_pll = nint * ref_rate / ref_div;
   587          ddr_pll += (lfrac * ref_rate) / ((ref_div * 25) << 13);
   588          ddr_pll += (hfrac >> 13) * ref_rate / ref_div;
                            ^^^^^^^^^^^
Same

   589          ddr_pll /= (1 << out_div);
   590  
   591          clk_ctrl = ath79_pll_rr(QCA956X_PLL_CLK_CTRL_REG);
   592  
   593          postdiv = (clk_ctrl >> QCA956X_PLL_CLK_CTRL_CPU_POST_DIV_SHIFT) &
   594                    QCA956X_PLL_CLK_CTRL_CPU_POST_DIV_MASK;

regards,
dan carpenter
