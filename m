Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 23:28:41 +0100 (CET)
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:42080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993911AbdAKW2db-l6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2017 23:28:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sandiskcorp.onmicrosoft.com; s=selector1-sandisk-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pqUKpznQKvh8KwFkrMH2UFMEiyW0QNPo4lp7XdOT4bg=;
 b=fFa2Jyp3YbfXztKthz0S/k1zCtsKOYr9kyjC68L1d8ucmCkjzjn4YLVn85RG+wM01QkPhCk+I2YEzP/R9rS1EeQPejbxPM/hw9LKTrcVCsESz/quXjLG0tbpdMPDoz3RnDDxJCQbtNuiJofweHa5rRXkGpDyYZ86Ou8dpbf/aPM=
Received: from BY2PR02CA0017.namprd02.prod.outlook.com (10.242.32.17) by
 BY2PR02MB1412.namprd02.prod.outlook.com (10.162.80.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.817.10; Wed, 11 Jan 2017 22:28:17 +0000
Received: from BN1BFFO11FD014.protection.gbl (2a01:111:f400:7c10::1:131) by
 BY2PR02CA0017.outlook.office365.com (2a01:111:e400:2c2a::17) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.817.10 via
 Frontend Transport; Wed, 11 Jan 2017 22:28:16 +0000
Authentication-Results: spf=pass (sender IP is 74.221.232.54)
 smtp.mailfrom=sandisk.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=sandisk.com;arm.com; dkim=none (message not signed)
 header.d=none;
Received-SPF: Pass (protection.outlook.com: domain of sandisk.com designates
 74.221.232.54 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.221.232.54; helo=sacsmgep14.sandisk.com;
Received: from sacsmgep14.sandisk.com (74.221.232.54) by
 BN1BFFO11FD014.mail.protection.outlook.com (10.58.144.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.803.8 via Frontend Transport; Wed, 11 Jan 2017 22:28:11 +0000
X-AuditID: ac1c2133-0c3ff70000013ebf-7c-58772c46dff8
Received: from SACHUBIP01.sdcorp.global.sandisk.com (Unknown_Domain [172.28.1.254])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id DA.6C.16063.64C27785; Wed, 11 Jan 2017 23:12:09 -0800 (PST)
Received: from SACCASIP04.sdcorp.global.sandisk.com (10.181.10.113) by
 SACHUBIP01.sdcorp.global.sandisk.com (10.181.10.103) with Microsoft SMTP
 Server (TLS) id 14.3.319.2; Wed, 11 Jan 2017 14:28:08 -0800
Received: from ULS-OP-MBXIP03.sdcorp.global.sandisk.com
 ([fe80::f9ec:1e1b:1439:62d8]) by SACCASIP04.sdcorp.global.sandisk.com ([::1])
 with mapi id 14.03.0319.002; Wed, 11 Jan 2017 14:28:07 -0800
From:   Bart Van Assche <Bart.VanAssche@sandisk.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "mulix@mulix.org" <mulix@mulix.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "geoff@infradead.org" <geoff@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "lftan@altera.com" <lftan@altera.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "starvik@axis.com" <starvik@axis.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>
Subject: Re: [PATCH 2/9] Move dma_ops from archdata into struct device
Thread-Topic: [PATCH 2/9] Move dma_ops from archdata into struct device
Thread-Index: AQHSbFn6ItxJjPbhik+C656I6OUbBw==
Date:   Wed, 11 Jan 2017 22:28:05 +0000
Message-ID: <1484173670.2619.28.camel@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
         <20170111005648.14988-3-bart.vanassche@sandisk.com>
         <20170111064803.GB26893@kroah.com> <1484158589.2619.14.camel@sandisk.com>
         <20170111203100.GB17895@kroah.com>
In-Reply-To: <20170111203100.GB17895@kroah.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.1.254]
Content-Type: multipart/mixed;
        boundary="_004_1484173670261928camelsandiskcom_"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Te0ybVRjGPd+duiafyOWITh3xEsfGnJL4ximZicrHHypGl+DiZXV8ATJu
        aRFlRkOAAaVTuwkYWsLoQAYM2q4413JxrCNsDIEOCOMqAwqssnAR3RhMsO0HBhP/e97nPL/3
        fc9JDkf6tnBBXHxSqqhMUiQEMzKq9jG0tjty1+fRzy/2yEBtW2XhijmDgfnK4wg0p88wYLi3
        QkNJdzYFY38MI5jLXKXA1b1Ag8Y4wUJO0WswPdRMQIUrHLLKTQwUnQuE5b+yKCi7uA/ujBsQ
        1PbkMDBmrKFhxq4j4X7xAgFqvZmFKe0IA3OjrQh0F0cpsEz209Cq1xJQddZIwny2lYGFvDka
        ehtKGDjjrCPdo3Ip0BaeZGHimoOAztIrDEzbv3F7hiwSSu4XkHBspI6A6s46FuyFzQhW767R
        0NNSRsD6D/UITJeGKcjXTTFgUfcy0Fx4E0FGexUNTasfQqelmoB6SyEJtx2/UXC+Y54E1+JV
        CpbNkzSMnWwm9u8TnJdKCeFYs5YRaktrkdDbf50UbhijhJ+qBwnBphtlhYXFj4X6qp1CeZOL
        ECw1akYoMzlpoUu/QAlzXV2sYLXMEoL9ch6Keuag7JUYMSE+TVTuCT8ki+vUGKiUHxfJL07P
        OqkM9O0kmY98OMyH4cuDK0Q+knG+fAWBT1V0s1LRjbDDlIOkog1hzXcnWQ/C8C9gvbaJ8mg/
        /lV8olJDekIk/zvG51rV7oLjHubfxMdNaVImAhu7cjfyobjXaaM9muKfxvrvLawnLnf3VE89
        Ls1yIWy9OuTN+/B7sPPevDeD+O04e/ZBj03ygXjIeYqQbuCHx693MJL2x67JNVrST+KlqjVG
        yr+L/7w94L2xnH8Itxc7ve19+Wdx+0gdqUUBui1tdVsQ3RZE8kPxQGEBI+mXce8JLSnpEFxp
        mHVrzq1jcG52nGS/j8sd15DO+0BjCBc3rKNNNnPwwsasHbhAM85K+hBuKLJu+FG4zThGSfAQ
        wo1WK7sJ990pZv4P7sks31giCjvqjkrsMMJ5BTX/Lt1xIfM/bBnyr0EBKsVhVWKsmLI3LFSl
        SIqJVx0JPZycaEHev7zjRStaM0fYEc+h4G1yoTEt2pdWpKnSE+3oKXejCfNZBwqikpKTxGA/
        +adm97E8RpF+VFQmf6L8LEFU2dGjHBUcKH+ipfGALx+rSBWPiGKKqNw8JTifoAxUQ5vku3MM
        ma19t9b7dv1ynlqNmMl944FtQ/UHnGGPHPxoaqZb+4Hh69ilBlvq9pf+9n/PgkPCXeFt2b82
        vRP2pTmyK6gyIjTnqxVL6nJk+bLu5v5bS4G2139ezLihT5+Jfm4uQJb2FrE8k+dcuds/EGh5
        Oy9euzRNhRf4hARFxw/axGBKFafYu5NUqhT/AFIGyTTTBAAA
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:74.221.232.54;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(39450400003)(39840400002)(39860400002)(39850400002)(39410400002)(2980300002)(438002)(3190300001)(189002)(199003)(377424004)(24454002)(1730700003)(5250100002)(5000100001)(7416002)(4326007)(7366002)(7406005)(5890100001)(84326002)(39060400001)(110136003)(4810100001)(2351001)(106116001)(106466001)(4610100001)(8676002)(6916009)(568964002)(103116003)(81156014)(68736007)(2950100002)(512934002)(2906002)(92566002)(2476003)(69596002)(7736002)(305945005)(356003)(2900100001)(5640700003)(81166006)(54906002)(36756003)(33646002)(8936002)(93886004)(76176999)(189998001)(229853002)(97736004)(30436002)(50986999)(575784001)(2501003)(86362001)(2270400002)(99936001)(5660300001)(6116002)(54356999)(3846002)(626004)(8666007)(38730400001)(102836003)(7099028);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1412;H:sacsmgep14.sandisk.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD014;1:Y7znxDCrDyFA2o5/LvLAYOV9wVeusc0AcAGckYmoM5zdyCt6HvR8ERdSCdMjo2a/AayniQ5YiOlfXZVvHYza98m3QRvwNLsz7UY5IAXmzU5thsBm9fNb7GrEmitmxldtIU1DeENgVibTfBrHlM21dXln81ysiwAwmTh2/V4+bgLdm0dGDIgINHoXCkKueDIJzeH6hi3n3UOIUALIMhCcmZVxszli/f0rVe0z7xvBSpVFRnUYVH50J+3f5yjRSbu+lveI0qXl8mKo2KvD7a+tB1JcZbJ0rUp/Izg5Kb3TwbeUQmV53D17UKU6vV13QmkjaC9wATwkEgOagTBkr6LlSByPucQzJmRDLO3N8js40J+O+oS4FjGd4QFaGI/0BZ/unCJ8TGZoqbPqUo2IZmyR5YhCNhHPMFI0L5eCQv/C3jY4CdL8I9c9My3VWax37GJH4PE6L3XLSjm/C6aBrQHxJawuhMqgrwGKvRthHU4i43NeIplEUGuSd575Gw0JVQChydlF9aKHTZVddkE4ngHgab6CvwDVOQ0za2zgLExYms9r4kIXRZqO2hb+lEqCoqmrk5dOzKbnmQAS0zK6YN18wuKnwwkqGZEe51pa9mwqTp/IONJkD0TQSPAjPIshXwOn
X-MS-Office365-Filtering-Correlation-Id: 3201744c-c6cf-4be0-f70d-08d43a71232f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002);SRVR:BY2PR02MB1412;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1412;3:X+O49coAzSXgAFVBuiT4YZzWBl7oyxQGhrtQVY7oUCjwxe2s9xSczs7vJxKt3UYReTBgtoqE1idVsJPZpN526V2zElTMWnnb+276k2HIoXGVTeR6OEWIdGgH5d3EqKkHS+UNMTOs16BOs+3dc0Uu6ofEG8qaZ+DGIZ0hjqaFjRGX0EECL+uKCspSPZCNJ4lMld2pHEH5GliNq+OA/tpRIqPGWPvPyGMOOYN2fUysh7+SUYHr0Dq4yV1zyxa0iNUme9HbgojC/kfxMX8I4r9FZ7To+fEqh0TGBY7L1NGmAiiDCmGlwFMdBZu6Ktslp0kHiH6QmClVb9t7hlChcrs2ngPDyvkEWvMBxsl4wZvuPd25rf3GoGiq82mIdNRvQZuzAX65kX2vym2ZHHaFYqLbHg==;25:r34AoHEVAhvif0aceBH+N9H1GJ3uiz94PCXaI7/L3BVvd5qA/fZNH/ibu0/2FKRuMp9EFbp+OCL9wjFglNwSGRgdudwRSELUFNQDUnOZDUEay2+v2rxMes4HrIGDTM8trYAW5lw9FAwC0R7/6iqZz3G9QTtGbn9A0DxJXHKT7htrAIkSE9++eD3rKMpHjGDUP99i1gcg32wrudhhG9QMwVlEq/f+50aHLBmXi8YviOlqZ4FepLWYUjbHCFMM0TdSDsFacnexKX/cu2az8cRfg1wGZ/fHOF5WeN9pWnOE5lFv/q3CfEYGI2RFO8A5FgY6jeGC0hJTUhFr+TWi58BRWNqG5CSN7arKM1xwlkxAV6oFLdhRNf99KUq399yberdXMKbofU0iy2UQWdAxjI9wf0+00Y8ZXfkDoRyNTggSTHTod2j6nQHtBCc7Es2l80jOVOhmmw/Gc5CtduX4WAi7rqx07jVeLdjziz+dgrCRfSq0Qga1LyeYVO80NENGSsW2sf/iezQACovtKkQUEGwRZw==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1412;31:0IozkLRid0DncS6kCPscY3o38iEGzgYoY8qYs4FJmPZWrJYgeBZ08IF9Bc1ko0MXacqLhQ+9BzmIRFlg1A5mjywPrbXetwdvypyA0mmrEt8RX/9zBwawMFjXPVv20Cf4/0KSp2x1pfiDMOb8xCVBqptzd22LS5/TZv58b2XuatF2YcHvibM2ez/pBYZ49Vr+WjFeia3LkphW6OSbQma02tsXyqzgGMaVrMa94QbfZHljy5Kybe1ewbpDM3R7N+YMOQXXvHkiJl/2D7WystTT4RyAu/2zOOFafdvyQWcrCJDBunf+iVPcV2T/pcWAaZmG;20:Q5SBaKLy9eY/CceiaGygdoG95rD9+jAEffEqzwDYU74ky0dm1ibtV/zErWhB+TJHdpxY9Y2CUDYgRLy5U1Efn4XHzJADRRiL+VPuA1qVaHkIoEW3hWBIMBjOc4YAU7C+TAazl3UjrAQ6o14MW++80ociytfPprMipPTXGVUUo648CvaUx4TOh+7oKlG9zq395B8T1XRzgNKptX1vm/zx8N5fkrjmjAL6aTtfjDr4CIR8IUNMMpgwImEl0vbDSbawSGCGQpLJ8AM/1Z/nfsFRKCgb/KqyM8ZzV0V1rQCk7Zv2qvJQRbOu+T44/miEJH+Q1ckTs471+9SJxmZ4q5IoaWf9RHQp4isOEBoUfwsFOWlnDtM0Gpd4cr6vMMoKfefU6zPhMhzJzvKUZtSGxTOH9ZZETaEQn08Ht3lpoKP1iOe+XKRQhXJi4a+nJfBxtbXUBHrIJN4XXP3gNjokE/qct/iWafNk0KRPVFiCzzBla1otNYdQyNFq6i2/16aA6LR7
X-Microsoft-Antispam-PRVS: <BY2PR02MB14122B49D2D244D5720B856F81660@BY2PR02MB1412.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42932892334569);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040375)(601004)(2401047)(13023025)(13017025)(13015025)(13024025)(13018025)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:BY2PR02MB1412;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1412;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1412;4:S4TsZcsPvMRd7USHPki/saExPWaC/f5/oFprb+fmTowL0CXwwqoZvsi/yCXaaZqCf+veeeBm9G/fmbTtveXBsRTeASBm+zUvRq1zvnncIox10fFZy5jMw+2g2omXO3y2Y3mOgct/X0eJ4PwPah1wG2/x8F4JrQ5WYgWnjDKW2AXUdKaTpbIK7IsLJqqTfzFEBvN0epCpe+cCEgKiITs8vW6ZK86JjHMc9/QfUUBJahfNHjV100uy/5911T2X5flwRI1SiICSqBoem6TBhlXFy3wmPCDtqOL3s1+6ZZ+lGztwc4vZZcSbT3tMTIHU5DrX3WvhapJnusW794l6pLnixXYTj75gsPM7NY2THK5+BGhcW2kCMPgSUJTwYrlBUD/IwzNZmkyzZo9vwKgEaq7L+jS3zjZ8h7XidhG/LBVCe0AnKx1Yyd4sNvyGNQBI6BYZbM2l0OtnMmuQfE+QtGFXPFg1lAWqVT1KS8cy47/0LIpCnAiTs11XNuZDAd6OCpJpcZWOjsxQs3QZS4+HEa7YFsAC2H2rmUhwc9NhKyqNu6tvJXGPU3NP44gwBwyAN1A1Qt8rlFMiuY9u1JlfU8hG25V96zOd/990iuSrtKSJuVhh7PfngVswadKNf/xFfVp4R6sGdnO+fdz+DyAz76UdE+iUEl90AtfryRI66eNVO4Mfz76zzLaHdSV/UxmrQFPm0mU9bVms+kaInbLwWlyt6My/0WLwDRDWKAiypuUQ104JXXhfKHBFdR1vsG556d6m
X-Forefront-PRVS: 01842C458A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1412;23:OhIPfjLQYK2Ba4Bg9v4PDN+09CNFIzIxwNWH8AjGP?=
 =?us-ascii?Q?wKoUCiDAl3RyxphQ13H7VYFXUkiLNGaZ9VRh9Y5jrrQZByIJTGrfT0HGZ94H?=
 =?us-ascii?Q?4TbECbAIrjM9N72UOmDIwZdtLujgxj1WTRQUrBGnz4rSI0Ao9hL6iCKHl7tY?=
 =?us-ascii?Q?gxL0PEI6FixRRhXpyPZFYTp37IEGLgG3A3aiDL8Yj0bhzZt4nOY9cDHPmS7K?=
 =?us-ascii?Q?pgCkK+sWhk+CJiNkrfQujgSOk3cnTqOzi8e8svMH59wZnBsGtQ1jDowIzfk8?=
 =?us-ascii?Q?ucdYDpNS1ZAyuaDELCa5iNFaGxV6Cgm0tg+zwESnwpPq30yUdpUVge5eZNyJ?=
 =?us-ascii?Q?huuVzg/OVwPNkf7wNgghhoZ2KgMeHVvVP47ZvORhwf47MYkJsOTgwk46wXjH?=
 =?us-ascii?Q?m+HH2n7T/RIGWv2bmNK5gB0StTGuuJpJW1CKpZkI8AG9js3plnu+5mgOAy8F?=
 =?us-ascii?Q?bnlLVsZaHy0FoE6/dLPbhOUxjBE3UWd+kdUyJD1gigHHTKlotx/D9D88Bt5a?=
 =?us-ascii?Q?US63DuN6M7+x5rS8ihnBYy2zwZlLIKEbJhwv2aMO6wSVh/gM4NG63oxVJtXc?=
 =?us-ascii?Q?/57O6XZqLHeq/rmIdkpqcSmFRiJuWdO2ayQuFwCHhg5gULsOdqrJAAK+wAnA?=
 =?us-ascii?Q?0elk2hHPYgWkvqoO1Vdj9wTCvhF1X4+agO/wkIFDhcVXJN59jOSL3NQSD1NO?=
 =?us-ascii?Q?m1+EHUi9fSLT4GrpcfWxq+ugsYDFmgEPO4zwNvQoIVe3sTfYDe22KPFoM29F?=
 =?us-ascii?Q?Ou6K+KsBgusHif1+Uy0ELc083mlvsWMhN8zNj+gtTDIiu13jnAbAXEwWs7Z/?=
 =?us-ascii?Q?EGHDhim1VzocUOnEUKNeWJHAK8F4LFRE31cHSqTBaZ93vHk0nSJeC7X5/gBl?=
 =?us-ascii?Q?gAqEX42zAp5tnXUOi80PvKLR/7um+rx/Wg0aLpfv9p5aarYR8yEf4Uda/Rjq?=
 =?us-ascii?Q?pTqKVVA46Rl91PmtwB3LcRPrF9T35WoZVNNTK1TDLLD0ExVmnx9YDvSSngmI?=
 =?us-ascii?Q?bU9aapz5nmoh8EuaWrrLLOhjhdje3D5gykhosuwGc7XhUmQSnBaczAs0pI8n?=
 =?us-ascii?Q?Gt9jzZx+hD6MBFY1n35LfPww3Q277SlDvr95OASP08d0FO29Rpq5Jz76RVL/?=
 =?us-ascii?Q?hCt+UIgWQdMp3j11nVVgZkaUHB4lT9G5oQM7ZypvnZuXvfoniSFUpPbVFPpC?=
 =?us-ascii?Q?6vtDScH/osg2yuJrIaLQWoULKtVtea7R6pOpR6ec+lJGsXgf+r+rXRnqf7VW?=
 =?us-ascii?Q?lI0vS7Ybi8jVdlmCcUykbPi17xKTl9iSxHxoJFF8hezlKOlBrh81UsNxDPra?=
 =?us-ascii?Q?hRNLQVm/+yO09IUN4aV170iGu/NR13Na7rgguhIJ/6lnH4qKvr6Wme7cm9EC?=
 =?us-ascii?Q?0D+qpQ2cr33aSXz2hEMjMsxo7NM6LHSOQI93sTZc7fR18DiuDS+bIiXbY4ex?=
 =?us-ascii?Q?0EaFXfiCzWiTg+sB8zeo4rXnfaQZzeUWtjdiaLPQEVI/gMfOrCRi2nUFM2pA?=
 =?us-ascii?Q?leLIaqG3Cc5ZEUosmd+Ce+SRDLlFVW7j3tr28CxPSEGZowJJmkc1eMrCBMHx?=
 =?us-ascii?Q?R8eJ5OpVvmwL3mbjOWlm5adapg4sfkvRfE3jp2JpTO3yrtEIYsBxUxV6k/5Q?=
 =?us-ascii?Q?fhWnXw70P6cXi8UtuU9PmpOG7MznHery7DLi8LRhRgnKQOzhXW/6KTBsg9EB?=
 =?us-ascii?Q?iyL4jDBgxk+P3waR9YJGKbyvNYZj5hui9BQ4d/7Q/phZx16YsZTArrY7grFz?=
 =?us-ascii?Q?37AaCpJg2VinkHIstBUyOEyzZ+dDg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1412;6:Ug3oKqI7SUnhunMpWU6cmSx2UnV7aWnbgtm3gxIYz5nA/wQFGSs770c9dKZGuYqiH4rKuWJ1cXxX/ErZT7DPzGY/JtQi2gPepb1pQaX2pxP2whYDHBnyC30zR467hmVzzTRrlJXEwto9kP+ChEICyQ7m5sMqTF5Q3g0OBfYTkXsugBAIBze1Pqy+oep6Z78CRsdyl4nV/Pt+HdCFqZOt5KVV3Eiw44Uzixe33NU2LChK6FJiDtqhFfySLNcjxC3Bl5IlvVf1lijWZFJs62kjbqteIG+tVRoebsiQ6Eb10FJXJOU5zJpThslBV8IladglCGbfq7XPcTURdV3JavKW+TVadZu1HVdub/JLcl+i6mdG9dMdGFyHM+t6JR7b19VUt9TiohUr7DbbPZj9TLXwMIOKgtHs/NhG2Pmn9witZG+t8eUyGqc48ItQhIA0nXd9jSsMr2gfVPcLS4J+69wwxg==;5:cMOTHrxGELDRH0h2IRAQbdAvFWArY5T3/oJ9iq3i+/e/QVvgyf2ea0LhY11e6fL6jiEGgIV71U6w6LSSFGEhexf9J6QaZGVCnrMu/BLVa9AYKrXHyuqarg/40MOlbrwHz8+r96KRoazftX5cPAYgVg==;24:29zdNZKs4zKcptme3GQkbV4Y0hKRacFyDTnlQG8NObjUvEKYXJ9FPrKnpcvo25YUHo2N3OZ0HEVRf4QIwZmfSQhj5pGxYl1TIkZen5vraUw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1412;7:egfdvPt5j/AsPYACpny/9TkpmOtJ01Wsyt1lWHBMMXBWwOB1yoe+YhlqHpHXxfwgor24Y3sLktNkRFqrUv3D7C0Vm+x2rh2nEZNAE39iv47RSJu0khU9VCBXiccgP6bjwZMj+GEo9pMtugxqAhOXzRx6ttO/myrg6iLYVselh2hZIQHiFadNqISRH7IGrPrBrwAYeUFLhsoIe5BNKrvE/FqiNsuk2oz8eaz1naG+WBc2wJVU9IJ+ycgIMpAibneYWivbczoQ4Imm9HsSjUHeGDfn3cBFeWOsMADh1A13oJYxwbKbuHZbQLOCJwqaoFu6Lt/rlpodaQ2eSTXZR3R56QI4WP83gHBdl5C9XBA/yenlhVJws/xh2EAftfAm3IqkSG7ZydFLyrXV/768Yra7GowxM1h2K61XXy40FoxL66WNPoNs46bhPEtFQKSkebV9FnnNCFKR3Gkyty2966B49A==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2017 22:28:11.0040
 (UTC)
X-MS-Exchange-CrossTenant-Id: fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d;Ip=[74.221.232.54];Helo=[sacsmgep14.sandisk.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1412
Return-Path: <Bart.VanAssche@sandisk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bart.VanAssche@sandisk.com
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

--_004_1484173670261928camelsandiskcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8CA25A75FA1D5A409ACFDA797937F603@sandisk.com>
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-01-11 at 21:31 +0100, gregkh@linuxfoundation.org wrote:
> That's a big sign that your patch series needs work.  Break it up into
> smaller pieces, it should be possible, which will make merges easier
> (well, different in a way.)

Hello Greg,

Can you have a look at the attached patches? These three patches are a
splitup of the single patch at the start of this e-mail thread.

Thanks,

Bart.=

--_004_1484173670261928camelsandiskcom_
Content-Type: text/x-patch;
	name="0001-treewide-Move-dma_ops-from-struct-dev_archdata-into-.patch"
Content-Description: 0001-treewide-Move-dma_ops-from-struct-dev_archdata-into-.patch
Content-Disposition: attachment;
	filename="0001-treewide-Move-dma_ops-from-struct-dev_archdata-into-.patch";
	size=22418; creation-date="Wed, 11 Jan 2017 22:28:04 GMT";
	modification-date="Wed, 11 Jan 2017 22:28:04 GMT"
Content-ID: <03D73F3964D8C442AF2CFE048FE58BF6@sandisk.com>
Content-Transfer-Encoding: base64

RnJvbSBhNmZlM2E2ZGI4MGYyYmMzNTllMDQ5YjcyZTEzYWExNzFmZmY2ZmZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHNhbmRp
c2suY29tPgpEYXRlOiBXZWQsIDExIEphbiAyMDE3IDEzOjMxOjQyIC0wODAwClN1YmplY3Q6IFtQ
QVRDSCAxLzNdIHRyZWV3aWRlOiBNb3ZlIGRtYV9vcHMgZnJvbSBzdHJ1Y3QgZGV2X2FyY2hkYXRh
IGludG8KIHN0cnVjdCBkZXZpY2UKClRoaXMgY2hhbmdlIGlzIG5lY2Vzc2FyeSB0byBtYWtlIHRo
ZSBkbWFfb3BzIHBvaW50ZXIgY29uZmlndXJhYmxlCnBlciBkZXZpY2Ugb24gYXJjaGl0ZWN0dXJl
cyB0aGF0IGRvIG5vdCB5ZXQgaW1wbGVtZW50IHNldF9kbWFfb3BzKCkuCgpTaWduZWQtb2ZmLWJ5
OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHNhbmRpc2suY29tPgotLS0KIGFyY2gv
YXJtL2luY2x1ZGUvYXNtL2RldmljZS5oICAgICAgICAgICAgfCAxIC0KIGFyY2gvYXJtL2luY2x1
ZGUvYXNtL2RtYS1tYXBwaW5nLmggICAgICAgfCA2ICsrKy0tLQogYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9kZXZpY2UuaCAgICAgICAgICB8IDEgLQogYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9kbWEt
bWFwcGluZy5oICAgICB8IDQgKystLQogYXJjaC9hcm02NC9tbS9kbWEtbWFwcGluZy5jICAgICAg
ICAgICAgICB8IDggKysrKy0tLS0KIGFyY2gvbTMyci9pbmNsdWRlL2FzbS9kZXZpY2UuaCAgICAg
ICAgICAgfCAxIC0KIGFyY2gvbTMyci9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgfCA0
ICsrLS0KIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9kZXZpY2UuaCAgICAgICAgICAgfCA1IC0tLS0t
CiBhcmNoL21pcHMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCAgICAgIHwgNCArKy0tCiBhcmNo
L21pcHMvcGNpL3BjaS1vY3Rlb24uYyAgICAgICAgICAgICAgIHwgMiArLQogYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL2RldmljZS5oICAgICAgICB8IDQgLS0tLQogYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL2RtYS1tYXBwaW5nLmggICB8IDQgKystLQogYXJjaC9wb3dlcnBjL2tlcm5lbC9kbWEu
YyAgICAgICAgICAgICAgICB8IDIgKy0KIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9pb21t
dS5jICAgICAgfCAyICstCiBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bhc2VtaS9pb21tdS5jICAg
IHwgMiArLQogYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wYXNlbWkvc2V0dXAuYyAgICB8IDIgKy0K
IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHMzL3N5c3RlbS1idXMuYyAgfCA0ICsrLS0KIGFyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9pYm1lYnVzLmMgfCAyICstCiBhcmNoL3MzOTAvaW5j
bHVkZS9hc20vZGV2aWNlLmggICAgICAgICAgIHwgMSAtCiBhcmNoL3MzOTAvaW5jbHVkZS9hc20v
ZG1hLW1hcHBpbmcuaCAgICAgIHwgNCArKy0tCiBhcmNoL3MzOTAvcGNpL3BjaS5jICAgICAgICAg
ICAgICAgICAgICAgIHwgMiArLQogYXJjaC90aWxlL2luY2x1ZGUvYXNtL2RldmljZS5oICAgICAg
ICAgICB8IDMgLS0tCiBhcmNoL3RpbGUvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCAgICAgIHwg
NiArKystLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2RldmljZS5oICAgICAgICAgICAgfCAzIC0t
LQogYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCAgICAgICB8IDQgKystLQogYXJj
aC94ODYva2VybmVsL3BjaS1jYWxnYXJ5XzY0LmMgICAgICAgICB8IDQgKystLQogYXJjaC94ODYv
cGNpL2NvbW1vbi5jICAgICAgICAgICAgICAgICAgICB8IDIgKy0KIGFyY2gveDg2L3BjaS9zdGEy
eDExLWZpeHVwLmMgICAgICAgICAgICAgfCA4ICsrKystLS0tCiBhcmNoL3h0ZW5zYS9pbmNsdWRl
L2FzbS9kZXZpY2UuaCAgICAgICAgIHwgNCAtLS0tCiBhcmNoL3h0ZW5zYS9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oICAgIHwgNCArKy0tCiBkcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycHQvaWJf
c3JwdC5jICAgIHwgMiArLQogZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYyAgICAgICAgICAgICAg
ICB8IDYgKysrLS0tCiBkcml2ZXJzL21pc2MvbWljL2J1cy9taWNfYnVzLmMgICAgICAgICAgIHwg
MiArLQogZHJpdmVycy9taXNjL21pYy9idXMvc2NpZl9idXMuYyAgICAgICAgICB8IDIgKy0KIGlu
Y2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAgICAgICAgICAgfCAxICsKIDM1IGZpbGVzIGNo
YW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDY5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2luY2x1ZGUvYXNtL2RldmljZS5oIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vZGV2aWNl
LmgKaW5kZXggZDhhNTcyZjljMTg3Li4yMjBiYTIwN2JlOTEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L2luY2x1ZGUvYXNtL2RldmljZS5oCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RldmljZS5o
CkBAIC03LDcgKzcsNiBAQAogI2RlZmluZSBBU01BUk1fREVWSUNFX0gKIAogc3RydWN0IGRldl9h
cmNoZGF0YSB7Ci0JY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzCSpkbWFfb3BzOwogI2lmZGVmIENP
TkZJR19ETUFCT1VOQ0UKIAlzdHJ1Y3QgZG1hYm91bmNlX2RldmljZV9pbmZvICpkbWFib3VuY2U7
CiAjZW5kaWYKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgg
Yi9hcmNoL2FybS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IDFhYWJkNzgxMzA2Zi4u
MzEyZjRkMDU2NGQ2IDEwMDY0NAotLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9kbWEtbWFwcGlu
Zy5oCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTE4LDggKzE4
LDggQEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyBhcm1fY29oZXJlbnRfZG1hX29w
czsKIAogc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKl9fZ2VuZXJpY19k
bWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKLQlpZiAoZGV2ICYmIGRldi0+YXJjaGRhdGEu
ZG1hX29wcykKLQkJcmV0dXJuIGRldi0+YXJjaGRhdGEuZG1hX29wczsKKwlpZiAoZGV2ICYmIGRl
di0+ZG1hX29wcykKKwkJcmV0dXJuIGRldi0+ZG1hX29wczsKIAlyZXR1cm4gJmFybV9kbWFfb3Bz
OwogfQogCkBAIC0zNCw3ICszNCw3IEBAIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9t
YXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCiBzdGF0aWMgaW5saW5lIHZv
aWQgc2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBzdHJ1Y3QgZG1hX21hcF9v
cHMgKm9wcykKIHsKIAlCVUdfT04oIWRldik7Ci0JZGV2LT5hcmNoZGF0YS5kbWFfb3BzID0gb3Bz
OworCWRldi0+ZG1hX29wcyA9IG9wczsKIH0KIAogI2RlZmluZSBIQVZFX0FSQ0hfRE1BX1NVUFBP
UlRFRCAxCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2RldmljZS5oIGIvYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9kZXZpY2UuaAppbmRleCAwMGM2NzhjYzMxZTEuLjczZDViYWIw
MTVlYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9kZXZpY2UuaAorKysgYi9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2RldmljZS5oCkBAIC0xNyw3ICsxNyw2IEBACiAjZGVmaW5l
IF9fQVNNX0RFVklDRV9ICiAKIHN0cnVjdCBkZXZfYXJjaGRhdGEgewotCWNvbnN0IHN0cnVjdCBk
bWFfbWFwX29wcyAqZG1hX29wczsKICNpZmRlZiBDT05GSUdfSU9NTVVfQVBJCiAJdm9pZCAqaW9t
bXU7CQkJLyogcHJpdmF0ZSBJT01NVSBkYXRhICovCiAjZW5kaWYKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20v
ZG1hLW1hcHBpbmcuaAppbmRleCAxZmVkYjQzYmU3MTIuLjU4YWUzNmNjM2I2MCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisrKyBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMjksOCArMjksOCBAQCBleHRlcm4gY29uc3Qg
c3RydWN0IGRtYV9tYXBfb3BzIGR1bW15X2RtYV9vcHM7CiAKIHN0YXRpYyBpbmxpbmUgY29uc3Qg
c3RydWN0IGRtYV9tYXBfb3BzICpfX2dlbmVyaWNfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYp
CiB7Ci0JaWYgKGRldiAmJiBkZXYtPmFyY2hkYXRhLmRtYV9vcHMpCi0JCXJldHVybiBkZXYtPmFy
Y2hkYXRhLmRtYV9vcHM7CisJaWYgKGRldiAmJiBkZXYtPmRtYV9vcHMpCisJCXJldHVybiBkZXYt
PmRtYV9vcHM7CiAKIAkvKgogCSAqIFdlIGV4cGVjdCBubyBJU0EgZGV2aWNlcywgYW5kIGFsbCBv
dGhlciBETUEgbWFzdGVycyBhcmUgZXhwZWN0ZWQgdG8KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
bW0vZG1hLW1hcHBpbmcuYyBiL2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYwppbmRleCBiY2Vm
NjM2OGQ0OGYuLmRiYWI0YzZjMDg0YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9tbS9kbWEtbWFw
cGluZy5jCisrKyBiL2FyY2gvYXJtNjQvbW0vZG1hLW1hcHBpbmcuYwpAQCAtODM3LDcgKzgzNyw3
IEBAIHN0YXRpYyBib29sIGRvX2lvbW11X2F0dGFjaChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0
IHN0cnVjdCBpb21tdV9vcHMgKm9wcywKIAkJcmV0dXJuIGZhbHNlOwogCX0KIAotCWRldi0+YXJj
aGRhdGEuZG1hX29wcyA9ICZpb21tdV9kbWFfb3BzOworCWRldi0+ZG1hX29wcyA9ICZpb21tdV9k
bWFfb3BzOwogCXJldHVybiB0cnVlOwogfQogCkBAIC05NDEsNyArOTQxLDcgQEAgc3RhdGljIHZv
aWQgX19pb21tdV9zZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IGRtYV9iYXNl
LCB1NjQgc2l6ZSwKIAogdm9pZCBhcmNoX3RlYXJkb3duX2RtYV9vcHMoc3RydWN0IGRldmljZSAq
ZGV2KQogewotCWRldi0+YXJjaGRhdGEuZG1hX29wcyA9IE5VTEw7CisJZGV2LT5kbWFfb3BzID0g
TlVMTDsKIH0KIAogI2Vsc2UKQEAgLTk1NSw4ICs5NTUsOCBAQCBzdGF0aWMgdm9pZCBfX2lvbW11
X3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgZG1hX2Jhc2UsIHU2NCBzaXpl
LAogdm9pZCBhcmNoX3NldHVwX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgZG1hX2Jh
c2UsIHU2NCBzaXplLAogCQkJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9tbXUsIGJvb2wgY29o
ZXJlbnQpCiB7Ci0JaWYgKCFkZXYtPmFyY2hkYXRhLmRtYV9vcHMpCi0JCWRldi0+YXJjaGRhdGEu
ZG1hX29wcyA9ICZzd2lvdGxiX2RtYV9vcHM7CisJaWYgKCFkZXYtPmRtYV9vcHMpCisJCWRldi0+
ZG1hX29wcyA9ICZzd2lvdGxiX2RtYV9vcHM7CiAKIAlkZXYtPmFyY2hkYXRhLmRtYV9jb2hlcmVu
dCA9IGNvaGVyZW50OwogCV9faW9tbXVfc2V0dXBfZG1hX29wcyhkZXYsIGRtYV9iYXNlLCBzaXpl
LCBpb21tdSk7CmRpZmYgLS1naXQgYS9hcmNoL20zMnIvaW5jbHVkZS9hc20vZGV2aWNlLmggYi9h
cmNoL20zMnIvaW5jbHVkZS9hc20vZGV2aWNlLmgKaW5kZXggNzk1NWE5Nzk5NDY2Li41MjAzZmM4
N2YwODAgMTAwNjQ0Ci0tLSBhL2FyY2gvbTMyci9pbmNsdWRlL2FzbS9kZXZpY2UuaAorKysgYi9h
cmNoL20zMnIvaW5jbHVkZS9hc20vZGV2aWNlLmgKQEAgLTQsNyArNCw2IEBACiAgKiBUaGlzIGZp
bGUgaXMgcmVsZWFzZWQgdW5kZXIgdGhlIEdQTHYyCiAgKi8KIHN0cnVjdCBkZXZfYXJjaGRhdGEg
ewotCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29wczsKIH07CiAKIHN0cnVjdCBwZGV2
X2FyY2hkYXRhIHsKZGlmZiAtLWdpdCBhL2FyY2gvbTMyci9pbmNsdWRlL2FzbS9kbWEtbWFwcGlu
Zy5oIGIvYXJjaC9tMzJyL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggOTljNDNkMmYw
NWRjLi4yN2IxNTk3YWM1NjMgMTAwNjQ0Ci0tLSBhL2FyY2gvbTMyci9pbmNsdWRlL2FzbS9kbWEt
bWFwcGluZy5oCisrKyBiL2FyY2gvbTMyci9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0x
Miw4ICsxMiw4IEBACiAKIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpn
ZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7Ci0JaWYgKGRldiAmJiBkZXYtPmFyY2hk
YXRhLmRtYV9vcHMpCi0JCXJldHVybiBkZXYtPmFyY2hkYXRhLmRtYV9vcHM7CisJaWYgKGRldiAm
JiBkZXYtPmRtYV9vcHMpCisJCXJldHVybiBkZXYtPmRtYV9vcHM7CiAJcmV0dXJuICZkbWFfbm9v
cF9vcHM7CiB9CiAKZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9kZXZpY2UuaCBi
L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9kZXZpY2UuaAppbmRleCBlYmM1YzEyNjU0NzMuLjZhYTc5
NmYxMDgxYSAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2RldmljZS5oCisrKyBi
L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9kZXZpY2UuaApAQCAtNiwxMiArNiw3IEBACiAjaWZuZGVm
IF9BU01fTUlQU19ERVZJQ0VfSAogI2RlZmluZSBfQVNNX01JUFNfREVWSUNFX0gKIAotc3RydWN0
IGRtYV9tYXBfb3BzOwotCiBzdHJ1Y3QgZGV2X2FyY2hkYXRhIHsKLQkvKiBETUEgb3BlcmF0aW9u
cyBvbiB0aGF0IGRldmljZSAqLwotCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29wczsK
LQogI2lmZGVmIENPTkZJR19ETUFfUEVSREVWX0NPSEVSRU5UCiAJLyogTm9uLXplcm8gaWYgRE1B
IGlzIGNvaGVyZW50IHdpdGggQ1BVIGNhY2hlcyAqLwogCWJvb2wgZG1hX2NvaGVyZW50OwpkaWZm
IC0tZ2l0IGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL21pcHMv
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCBiNTliMDg0YTc1NjkuLmRhZDNiMDlmZTk5
MyAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIv
YXJjaC9taXBzL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTEzLDggKzEzLDggQEAgZXh0
ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqbWlwc19kbWFfbWFwX29wczsKIAogc3RhdGlj
IGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZp
Y2UgKmRldikKIHsKLQlpZiAoZGV2ICYmIGRldi0+YXJjaGRhdGEuZG1hX29wcykKLQkJcmV0dXJu
IGRldi0+YXJjaGRhdGEuZG1hX29wczsKKwlpZiAoZGV2ICYmIGRldi0+ZG1hX29wcykKKwkJcmV0
dXJuIGRldi0+ZG1hX29wczsKIAllbHNlCiAJCXJldHVybiBtaXBzX2RtYV9tYXBfb3BzOwogfQpk
aWZmIC0tZ2l0IGEvYXJjaC9taXBzL3BjaS9wY2ktb2N0ZW9uLmMgYi9hcmNoL21pcHMvcGNpL3Bj
aS1vY3Rlb24uYwppbmRleCAzMDhkMDUxZmM0NWMuLjllZTAxOTM2ODYyZSAxMDA2NDQKLS0tIGEv
YXJjaC9taXBzL3BjaS9wY2ktb2N0ZW9uLmMKKysrIGIvYXJjaC9taXBzL3BjaS9wY2ktb2N0ZW9u
LmMKQEAgLTE2Nyw3ICsxNjcsNyBAQCBpbnQgcGNpYmlvc19wbGF0X2Rldl9pbml0KHN0cnVjdCBw
Y2lfZGV2ICpkZXYpCiAJCXBjaV93cml0ZV9jb25maWdfZHdvcmQoZGV2LCBwb3MgKyBQQ0lfRVJS
X1JPT1RfU1RBVFVTLCBkY29uZmlnKTsKIAl9CiAKLQlkZXYtPmRldi5hcmNoZGF0YS5kbWFfb3Bz
ID0gb2N0ZW9uX3BjaV9kbWFfbWFwX29wczsKKwlkZXYtPmRldi5kbWFfb3BzID0gb2N0ZW9uX3Bj
aV9kbWFfbWFwX29wczsKIAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL2RldmljZS5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2RldmljZS5o
CmluZGV4IDQ5Y2JiMGZjYTIzMy4uMDI0NWJmY2FhYzMyIDEwMDY0NAotLS0gYS9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vZGV2aWNlLmgKKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Rl
dmljZS5oCkBAIC02LDcgKzYsNiBAQAogI2lmbmRlZiBfQVNNX1BPV0VSUENfREVWSUNFX0gKICNk
ZWZpbmUgX0FTTV9QT1dFUlBDX0RFVklDRV9ICiAKLXN0cnVjdCBkbWFfbWFwX29wczsKIHN0cnVj
dCBkZXZpY2Vfbm9kZTsKICNpZmRlZiBDT05GSUdfUFBDNjQKIHN0cnVjdCBwY2lfZG47CkBAIC0y
MCw5ICsxOSw2IEBAIHN0cnVjdCBpb21tdV90YWJsZTsKICAqIGRyaXZlcnMvbWFjaW50b3NoL21h
Y2lvX2FzaWMuYwogICovCiBzdHJ1Y3QgZGV2X2FyY2hkYXRhIHsKLQkvKiBETUEgb3BlcmF0aW9u
cyBvbiB0aGF0IGRldmljZSAqLwotCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcwkqZG1hX29wczsK
LQogCS8qCiAJICogVGhlc2UgdHdvIHVzZWQgdG8gYmUgYSB1bmlvbi4gSG93ZXZlciwgd2l0aCB0
aGUgaHlicmlkIG9wcyB3ZSBuZWVkCiAJICogYm90aCBzbyBoZXJlIHdlIHN0b3JlIGJvdGggYSBE
TUEgb2Zmc2V0IGZvciBkaXJlY3QgbWFwcGluZ3MgYW5kCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCmluZGV4IDJlYzNlYWRmMzM2Zi4uNTlmYmQ0YWJjYmY4IDEwMDY0NAotLS0g
YS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtODgsMTIgKzg4LDEyIEBAIHN0YXRpYyBp
bmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNl
ICpkZXYpCiAJaWYgKHVubGlrZWx5KGRldiA9PSBOVUxMKSkKIAkJcmV0dXJuIE5VTEw7CiAKLQly
ZXR1cm4gZGV2LT5hcmNoZGF0YS5kbWFfb3BzOworCXJldHVybiBkZXYtPmRtYV9vcHM7CiB9CiAK
IHN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0
IHN0cnVjdCBkbWFfbWFwX29wcyAqb3BzKQogewotCWRldi0+YXJjaGRhdGEuZG1hX29wcyA9IG9w
czsKKwlkZXYtPmRtYV9vcHMgPSBvcHM7CiB9CiAKIC8qCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMva2VybmVsL2RtYS5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9kbWEuYwppbmRleCAwM2I5OGYx
Zjk4ZWMuLjQxYzc0OTU4NmJkMiAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9kbWEu
YworKysgYi9hcmNoL3Bvd2VycGMva2VybmVsL2RtYS5jCkBAIC0zMyw3ICszMyw3IEBAIHN0YXRp
YyB1NjQgX19tYXliZV91bnVzZWQgZ2V0X3Bmbl9saW1pdChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJ
c3RydWN0IGRldl9hcmNoZGF0YSBfX21heWJlX3VudXNlZCAqc2QgPSAmZGV2LT5hcmNoZGF0YTsK
IAogI2lmZGVmIENPTkZJR19TV0lPVExCCi0JaWYgKHNkLT5tYXhfZGlyZWN0X2RtYV9hZGRyICYm
IHNkLT5kbWFfb3BzID09ICZzd2lvdGxiX2RtYV9vcHMpCisJaWYgKHNkLT5tYXhfZGlyZWN0X2Rt
YV9hZGRyICYmIGRldi0+ZG1hX29wcyA9PSAmc3dpb3RsYl9kbWFfb3BzKQogCQlwZm4gPSBtaW5f
dCh1NjQsIHBmbiwgc2QtPm1heF9kaXJlY3RfZG1hX2FkZHIgPj4gUEFHRV9TSElGVCk7CiAjZW5k
aWYKIApkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxsL2lvbW11LmMgYi9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NlbGwvaW9tbXUuYwppbmRleCBlMTQxM2U2OWU1ZmUuLjcx
Yjk5NWJiY2FlMCAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxsL2lvbW11
LmMKKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxsL2lvbW11LmMKQEAgLTY5Miw3ICs2
OTIsNyBAQCBzdGF0aWMgaW50IGNlbGxfb2ZfYnVzX25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxv
Y2sgKm5iLCB1bnNpZ25lZCBsb25nIGFjdGlvbiwKIAkJcmV0dXJuIDA7CiAKIAkvKiBXZSB1c2Ug
dGhlIFBDSSBETUEgb3BzICovCi0JZGV2LT5hcmNoZGF0YS5kbWFfb3BzID0gZ2V0X3BjaV9kbWFf
b3BzKCk7CisJZGV2LT5kbWFfb3BzID0gZ2V0X3BjaV9kbWFfb3BzKCk7CiAKIAljZWxsX2RtYV9k
ZXZfc2V0dXAoZGV2KTsKIApkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wYXNl
bWkvaW9tbXUuYyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcGFzZW1pL2lvbW11LmMKaW5kZXgg
ZTc0YWRjNGU3ZmQ4Li43ZmVjMDRkZTI3ZmMgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcGFzZW1pL2lvbW11LmMKKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wYXNlbWkv
aW9tbXUuYwpAQCAtMTg2LDcgKzE4Niw3IEBAIHN0YXRpYyB2b2lkIHBjaV9kbWFfZGV2X3NldHVw
X3Bhc2VtaShzdHJ1Y3QgcGNpX2RldiAqZGV2KQogCSAqLwogCWlmIChkZXYtPnZlbmRvciA9PSAw
eDE5NTkgJiYgZGV2LT5kZXZpY2UgPT0gMHhhMDA3ICYmCiAJICAgICFmaXJtd2FyZV9oYXNfZmVh
dHVyZShGV19GRUFUVVJFX0xQQVIpKSB7Ci0JCWRldi0+ZGV2LmFyY2hkYXRhLmRtYV9vcHMgPSAm
ZG1hX2RpcmVjdF9vcHM7CisJCWRldi0+ZGV2LmRtYV9vcHMgPSAmZG1hX2RpcmVjdF9vcHM7CiAJ
CS8qCiAJCSAqIFNldCB0aGUgY29oZXJlbnQgRE1BIG1hc2sgdG8gcHJldmVudCB0aGUgaW9tbXUK
IAkJICogYmVpbmcgdXNlZCB1bm5lY2Vzc2FyaWx5CmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
cGxhdGZvcm1zL3Bhc2VtaS9zZXR1cC5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wYXNlbWkv
c2V0dXAuYwppbmRleCAzMTgyNDAwY2Y0OGYuLmM0YTNlOTNkYzMyNCAxMDA2NDQKLS0tIGEvYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy9wYXNlbWkvc2V0dXAuYworKysgYi9hcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3Bhc2VtaS9zZXR1cC5jCkBAIC0zNjMsNyArMzYzLDcgQEAgc3RhdGljIGludCBwY21j
aWFfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVuc2lnbmVkIGxvbmcgYWN0aW9u
LAogCQlyZXR1cm4gMDsKIAogCS8qIFdlIHVzZSB0aGUgZGlyZWN0IG9wcyBmb3IgbG9jYWxidXMg
Ki8KLQlkZXYtPmFyY2hkYXRhLmRtYV9vcHMgPSAmZG1hX2RpcmVjdF9vcHM7CisJZGV2LT5kbWFf
b3BzID0gJmRtYV9kaXJlY3Rfb3BzOwogCiAJcmV0dXJuIDA7CiB9CmRpZmYgLS1naXQgYS9hcmNo
L3Bvd2VycGMvcGxhdGZvcm1zL3BzMy9zeXN0ZW0tYnVzLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zL3BzMy9zeXN0ZW0tYnVzLmMKaW5kZXggYzgxNDUwZDk4Nzk0Li4yZDJlNWY4MGEzZDMgMTAw
NjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHMzL3N5c3RlbS1idXMuYworKysgYi9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzMy9zeXN0ZW0tYnVzLmMKQEAgLTc1NiwxMSArNzU2LDEx
IEBAIGludCBwczNfc3lzdGVtX2J1c19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0IHBzM19zeXN0ZW1f
YnVzX2RldmljZSAqZGV2KQogCiAJc3dpdGNoIChkZXYtPmRldl90eXBlKSB7CiAJY2FzZSBQUzNf
REVWSUNFX1RZUEVfSU9DMDoKLQkJZGV2LT5jb3JlLmFyY2hkYXRhLmRtYV9vcHMgPSAmcHMzX2lv
YzBfZG1hX29wczsKKwkJZGV2LT5jb3JlLmRtYV9vcHMgPSAmcHMzX2lvYzBfZG1hX29wczsKIAkJ
ZGV2X3NldF9uYW1lKCZkZXYtPmNvcmUsICJpb2MwXyUwMngiLCArK2Rldl9pb2MwX2NvdW50KTsK
IAkJYnJlYWs7CiAJY2FzZSBQUzNfREVWSUNFX1RZUEVfU0I6Ci0JCWRldi0+Y29yZS5hcmNoZGF0
YS5kbWFfb3BzID0gJnBzM19zYl9kbWFfb3BzOworCQlkZXYtPmNvcmUuZG1hX29wcyA9ICZwczNf
c2JfZG1hX29wczsKIAkJZGV2X3NldF9uYW1lKCZkZXYtPmNvcmUsICJzYl8lMDJ4IiwgKytkZXZf
c2JfY291bnQpOwogCiAJCWJyZWFrOwpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jt
cy9wc2VyaWVzL2libWVidXMuYyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9pYm1l
YnVzLmMKaW5kZXggMmUzNmEwYjg5NDRhLi45OWE2YmY3ZjNiY2YgMTAwNjQ0Ci0tLSBhL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9pYm1lYnVzLmMKKysrIGIvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wc2VyaWVzL2libWVidXMuYwpAQCAtMTY5LDcgKzE2OSw3IEBAIHN0YXRpYyBpbnQg
aWJtZWJ1c19jcmVhdGVfZGV2aWNlKHN0cnVjdCBkZXZpY2Vfbm9kZSAqZG4pCiAJCXJldHVybiAt
RU5PTUVNOwogCiAJZGV2LT5kZXYuYnVzID0gJmlibWVidXNfYnVzX3R5cGU7Ci0JZGV2LT5kZXYu
YXJjaGRhdGEuZG1hX29wcyA9ICZpYm1lYnVzX2RtYV9vcHM7CisJZGV2LT5kZXYuZG1hX29wcyA9
ICZpYm1lYnVzX2RtYV9vcHM7CiAKIAlyZXQgPSBvZl9kZXZpY2VfYWRkKGRldik7CiAJaWYgKHJl
dCkKZGlmZiAtLWdpdCBhL2FyY2gvczM5MC9pbmNsdWRlL2FzbS9kZXZpY2UuaCBiL2FyY2gvczM5
MC9pbmNsdWRlL2FzbS9kZXZpY2UuaAppbmRleCA3OTU1YTk3OTk0NjYuLjUyMDNmYzg3ZjA4MCAx
MDA2NDQKLS0tIGEvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL2RldmljZS5oCisrKyBiL2FyY2gvczM5
MC9pbmNsdWRlL2FzbS9kZXZpY2UuaApAQCAtNCw3ICs0LDYgQEAKICAqIFRoaXMgZmlsZSBpcyBy
ZWxlYXNlZCB1bmRlciB0aGUgR1BMdjIKICAqLwogc3RydWN0IGRldl9hcmNoZGF0YSB7Ci0JY29u
c3Qgc3RydWN0IGRtYV9tYXBfb3BzICpkbWFfb3BzOwogfTsKIAogc3RydWN0IHBkZXZfYXJjaGRh
dGEgewpkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9h
cmNoL3MzOTAvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCAyNzc2ZDIwNWIxZmYuLmE4
NzIwMjdkMGMxYiAxMDA2NDQKLS0tIGEvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5n
LmgKKysrIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTE0LDggKzE0
LDggQEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyBzMzkwX3BjaV9kbWFfb3BzOwog
CiBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3Ry
dWN0IGRldmljZSAqZGV2KQogewotCWlmIChkZXYgJiYgZGV2LT5hcmNoZGF0YS5kbWFfb3BzKQot
CQlyZXR1cm4gZGV2LT5hcmNoZGF0YS5kbWFfb3BzOworCWlmIChkZXYgJiYgZGV2LT5kbWFfb3Bz
KQorCQlyZXR1cm4gZGV2LT5kbWFfb3BzOwogCXJldHVybiAmZG1hX25vb3Bfb3BzOwogfQogCmRp
ZmYgLS1naXQgYS9hcmNoL3MzOTAvcGNpL3BjaS5jIGIvYXJjaC9zMzkwL3BjaS9wY2kuYwppbmRl
eCAzOGUxN2Q0ZDk4ODQuLjgyYWJlZjhiODU3NCAxMDA2NDQKLS0tIGEvYXJjaC9zMzkwL3BjaS9w
Y2kuYworKysgYi9hcmNoL3MzOTAvcGNpL3BjaS5jCkBAIC02NDEsNyArNjQxLDcgQEAgaW50IHBj
aWJpb3NfYWRkX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKIAlpbnQgaTsKIAogCXBkZXYt
PmRldi5ncm91cHMgPSB6cGNpX2F0dHJfZ3JvdXBzOwotCXBkZXYtPmRldi5hcmNoZGF0YS5kbWFf
b3BzID0gJnMzOTBfcGNpX2RtYV9vcHM7CisJcGRldi0+ZGV2LmRtYV9vcHMgPSAmczM5MF9wY2lf
ZG1hX29wczsKIAl6cGNpX21hcF9yZXNvdXJjZXMocGRldik7CiAKIAlmb3IgKGkgPSAwOyBpIDwg
UENJX0JBUl9DT1VOVDsgaSsrKSB7CmRpZmYgLS1naXQgYS9hcmNoL3RpbGUvaW5jbHVkZS9hc20v
ZGV2aWNlLmggYi9hcmNoL3RpbGUvaW5jbHVkZS9hc20vZGV2aWNlLmgKaW5kZXggMjVmMjNhYzdk
MzYxLi4xY2Y0NTQyMmEwZGYgMTAwNjQ0Ci0tLSBhL2FyY2gvdGlsZS9pbmNsdWRlL2FzbS9kZXZp
Y2UuaAorKysgYi9hcmNoL3RpbGUvaW5jbHVkZS9hc20vZGV2aWNlLmgKQEAgLTE3LDkgKzE3LDYg
QEAKICNkZWZpbmUgX0FTTV9USUxFX0RFVklDRV9ICiAKIHN0cnVjdCBkZXZfYXJjaGRhdGEgewot
CS8qIERNQSBvcGVyYXRpb25zIG9uIHRoYXQgZGV2aWNlICovCi0gICAgICAgIGNvbnN0IHN0cnVj
dCBkbWFfbWFwX29wcwkqZG1hX29wczsKLQogCS8qIE9mZnNldCBvZiB0aGUgRE1BIGFkZHJlc3Mg
ZnJvbSB0aGUgUEEuICovCiAJZG1hX2FkZHJfdAkJZG1hX29mZnNldDsKIApkaWZmIC0tZ2l0IGEv
YXJjaC90aWxlL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL3RpbGUvaW5jbHVkZS9h
c20vZG1hLW1hcHBpbmcuaAppbmRleCA0YTA2Y2M3NWI4NTYuLmMwNjIwNjk3ZWFhZCAxMDA2NDQK
LS0tIGEvYXJjaC90aWxlL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC90aWxl
L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTMxLDggKzMxLDggQEAgZXh0ZXJuIGNvbnN0
IHN0cnVjdCBkbWFfbWFwX29wcyAqZ3hfaHlicmlkX3BjaV9kbWFfbWFwX29wczsKIAogc3RhdGlj
IGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZp
Y2UgKmRldikKIHsKLQlpZiAoZGV2ICYmIGRldi0+YXJjaGRhdGEuZG1hX29wcykKLQkJcmV0dXJu
IGRldi0+YXJjaGRhdGEuZG1hX29wczsKKwlpZiAoZGV2ICYmIGRldi0+ZG1hX29wcykKKwkJcmV0
dXJuIGRldi0+ZG1hX29wczsKIAllbHNlCiAJCXJldHVybiB0aWxlX2RtYV9tYXBfb3BzOwogfQpA
QCAtNjEsNyArNjEsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZG1hX21hcmtfY2xlYW4odm9pZCAq
YWRkciwgc2l6ZV90IHNpemUpIHt9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfZG1hX29wcyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqb3BzKQogewotCWRl
di0+YXJjaGRhdGEuZG1hX29wcyA9IG9wczsKKwlkZXYtPmRtYV9vcHMgPSBvcHM7CiB9CiAKIHN0
YXRpYyBpbmxpbmUgYm9vbCBkbWFfY2FwYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGRtYV9hZGRy
X3QgYWRkciwgc2l6ZV90IHNpemUpCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9k
ZXZpY2UuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2RldmljZS5oCmluZGV4IGIyZDBiNGNlZDdl
My4uMWIzZWYyNmU3N2RmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kZXZpY2Uu
aAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kZXZpY2UuaApAQCAtMiw5ICsyLDYgQEAKICNk
ZWZpbmUgX0FTTV9YODZfREVWSUNFX0gKIAogc3RydWN0IGRldl9hcmNoZGF0YSB7Ci0jaWZkZWYg
Q09ORklHX1g4Nl9ERVZfRE1BX09QUwotCWNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29w
czsKLSNlbmRpZgogI2lmIGRlZmluZWQoQ09ORklHX0lOVEVMX0lPTU1VKSB8fCBkZWZpbmVkKENP
TkZJR19BTURfSU9NTVUpCiAJdm9pZCAqaW9tbXU7IC8qIGhvb2sgZm9yIElPTU1VIHNwZWNpZmlj
IGV4dGVuc2lvbiAqLwogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCA1
ZTQ3NzI4ODZhMWUuLjk0YjViOTY5NjZjYiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5o
CkBAIC0zMiwxMCArMzIsMTAgQEAgc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9v
cHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKICNpZm5kZWYgQ09ORklHX1g4Nl9E
RVZfRE1BX09QUwogCXJldHVybiBkbWFfb3BzOwogI2Vsc2UKLQlpZiAodW5saWtlbHkoIWRldikg
fHwgIWRldi0+YXJjaGRhdGEuZG1hX29wcykKKwlpZiAodW5saWtlbHkoIWRldikgfHwgIWRldi0+
ZG1hX29wcykKIAkJcmV0dXJuIGRtYV9vcHM7CiAJZWxzZQotCQlyZXR1cm4gZGV2LT5hcmNoZGF0
YS5kbWFfb3BzOworCQlyZXR1cm4gZGV2LT5kbWFfb3BzOwogI2VuZGlmCiB9CiAKZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9wY2ktY2FsZ2FyeV82NC5jIGIvYXJjaC94ODYva2VybmVsL3Bj
aS1jYWxnYXJ5XzY0LmMKaW5kZXggMTdmMTgwMTQ4YzgwLi41MDcwMzIwNzgwYzYgMTAwNjQ0Ci0t
LSBhL2FyY2gveDg2L2tlcm5lbC9wY2ktY2FsZ2FyeV82NC5jCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9wY2ktY2FsZ2FyeV82NC5jCkBAIC0xMTc3LDcgKzExNzcsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCBjYWxnYXJ5X2luaXQodm9pZCkKIAkJdGJsID0gZmluZF9pb21tdV90YWJsZSgmZGV2LT5kZXYp
OwogCiAJCWlmICh0cmFuc2xhdGlvbl9lbmFibGVkKHRibCkpCi0JCQlkZXYtPmRldi5hcmNoZGF0
YS5kbWFfb3BzID0gJmNhbGdhcnlfZG1hX29wczsKKwkJCWRldi0+ZGV2LmRtYV9vcHMgPSAmY2Fs
Z2FyeV9kbWFfb3BzOwogCX0KIAogCXJldHVybiByZXQ7CkBAIC0xMjAxLDcgKzEyMDEsNyBAQCBz
dGF0aWMgaW50IF9faW5pdCBjYWxnYXJ5X2luaXQodm9pZCkKIAkJY2FsZ2FyeV9kaXNhYmxlX3Ry
YW5zbGF0aW9uKGRldik7CiAJCWNhbGdhcnlfZnJlZV9idXMoZGV2KTsKIAkJcGNpX2Rldl9wdXQo
ZGV2KTsgLyogVW5kbyBjYWxnYXJ5X2luaXRfb25lKCkncyBwY2lfZGV2X2dldCgpICovCi0JCWRl
di0+ZGV2LmFyY2hkYXRhLmRtYV9vcHMgPSBOVUxMOworCQlkZXYtPmRldi5kbWFfb3BzID0gTlVM
TDsKIAl9IHdoaWxlICgxKTsKIAogCXJldHVybiByZXQ7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9w
Y2kvY29tbW9uLmMgYi9hcmNoL3g4Ni9wY2kvY29tbW9uLmMKaW5kZXggYTRmZGZhN2RjYzFiLi4w
Y2I1MmFlMGE4ZjAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3BjaS9jb21tb24uYworKysgYi9hcmNo
L3g4Ni9wY2kvY29tbW9uLmMKQEAgLTY2Nyw3ICs2NjcsNyBAQCBzdGF0aWMgdm9pZCBzZXRfZG1h
X2RvbWFpbl9vcHMoc3RydWN0IHBjaV9kZXYgKnBkZXYpCiAJc3Bpbl9sb2NrKCZkbWFfZG9tYWlu
X2xpc3RfbG9jayk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShkb21haW4sICZkbWFfZG9tYWluX2xp
c3QsIG5vZGUpIHsKIAkJaWYgKHBjaV9kb21haW5fbnIocGRldi0+YnVzKSA9PSBkb21haW4tPmRv
bWFpbl9ucikgewotCQkJcGRldi0+ZGV2LmFyY2hkYXRhLmRtYV9vcHMgPSBkb21haW4tPmRtYV9v
cHM7CisJCQlwZGV2LT5kZXYuZG1hX29wcyA9IGRvbWFpbi0+ZG1hX29wczsKIAkJCWJyZWFrOwog
CQl9CiAJfQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvcGNpL3N0YTJ4MTEtZml4dXAuYyBiL2FyY2gv
eDg2L3BjaS9zdGEyeDExLWZpeHVwLmMKaW5kZXggYWEzODI4ODIzMTcwLi5lYzAwOGU4MDBiNDUg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3BjaS9zdGEyeDExLWZpeHVwLmMKKysrIGIvYXJjaC94ODYv
cGNpL3N0YTJ4MTEtZml4dXAuYwpAQCAtMjAzLDcgKzIwMyw3IEBAIHN0YXRpYyB2b2lkIHN0YTJ4
MTFfc2V0dXBfcGRldihzdHJ1Y3QgcGNpX2RldiAqcGRldikKIAkJcmV0dXJuOwogCXBjaV9zZXRf
Y29uc2lzdGVudF9kbWFfbWFzayhwZGV2LCBTVEEyWDExX0FNQkFfU0laRSAtIDEpOwogCXBjaV9z
ZXRfZG1hX21hc2socGRldiwgU1RBMlgxMV9BTUJBX1NJWkUgLSAxKTsKLQlwZGV2LT5kZXYuYXJj
aGRhdGEuZG1hX29wcyA9ICZzdGEyeDExX2RtYV9vcHM7CisJcGRldi0+ZGV2LmRtYV9vcHMgPSAm
c3RhMngxMV9kbWFfb3BzOwogCiAJLyogV2UgbXVzdCBlbmFibGUgYWxsIGRldmljZXMgYXMgbWFz
dGVyLCBmb3IgYXVkaW8gRE1BIHRvIHdvcmsgKi8KIAlwY2lfc2V0X21hc3RlcihwZGV2KTsKQEAg
LTIyMyw3ICsyMjMsNyBAQCBib29sIGRtYV9jYXBhYmxlKHN0cnVjdCBkZXZpY2UgKmRldiwgZG1h
X2FkZHJfdCBhZGRyLCBzaXplX3Qgc2l6ZSkKIHsKIAlzdHJ1Y3Qgc3RhMngxMV9tYXBwaW5nICpt
YXA7CiAKLQlpZiAoZGV2LT5hcmNoZGF0YS5kbWFfb3BzICE9ICZzdGEyeDExX2RtYV9vcHMpIHsK
KwlpZiAoZGV2LT5kbWFfb3BzICE9ICZzdGEyeDExX2RtYV9vcHMpIHsKIAkJaWYgKCFkZXYtPmRt
YV9tYXNrKQogCQkJcmV0dXJuIGZhbHNlOwogCQlyZXR1cm4gYWRkciArIHNpemUgLSAxIDw9ICpk
ZXYtPmRtYV9tYXNrOwpAQCAtMjQ3LDcgKzI0Nyw3IEBAIGJvb2wgZG1hX2NhcGFibGUoc3RydWN0
IGRldmljZSAqZGV2LCBkbWFfYWRkcl90IGFkZHIsIHNpemVfdCBzaXplKQogICovCiBkbWFfYWRk
cl90IHBoeXNfdG9fZG1hKHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QgcGFkZHIpCiB7
Ci0JaWYgKGRldi0+YXJjaGRhdGEuZG1hX29wcyAhPSAmc3RhMngxMV9kbWFfb3BzKQorCWlmIChk
ZXYtPmRtYV9vcHMgIT0gJnN0YTJ4MTFfZG1hX29wcykKIAkJcmV0dXJuIHBhZGRyOwogCXJldHVy
biBwMmEocGFkZHIsIHRvX3BjaV9kZXYoZGV2KSk7CiB9CkBAIC0yNTksNyArMjU5LDcgQEAgZG1h
X2FkZHJfdCBwaHlzX3RvX2RtYShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHBhZGRy
KQogICovCiBwaHlzX2FkZHJfdCBkbWFfdG9fcGh5cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIGRtYV9h
ZGRyX3QgZGFkZHIpCiB7Ci0JaWYgKGRldi0+YXJjaGRhdGEuZG1hX29wcyAhPSAmc3RhMngxMV9k
bWFfb3BzKQorCWlmIChkZXYtPmRtYV9vcHMgIT0gJnN0YTJ4MTFfZG1hX29wcykKIAkJcmV0dXJu
IGRhZGRyOwogCXJldHVybiBhMnAoZGFkZHIsIHRvX3BjaV9kZXYoZGV2KSk7CiB9CmRpZmYgLS1n
aXQgYS9hcmNoL3h0ZW5zYS9pbmNsdWRlL2FzbS9kZXZpY2UuaCBiL2FyY2gveHRlbnNhL2luY2x1
ZGUvYXNtL2RldmljZS5oCmluZGV4IGE3N2Q0NWQzOWYzNS4uMWRlZWI4ZWJiYjFiIDEwMDY0NAot
LS0gYS9hcmNoL3h0ZW5zYS9pbmNsdWRlL2FzbS9kZXZpY2UuaAorKysgYi9hcmNoL3h0ZW5zYS9p
bmNsdWRlL2FzbS9kZXZpY2UuaApAQCAtNiwxMSArNiw3IEBACiAjaWZuZGVmIF9BU01fWFRFTlNB
X0RFVklDRV9ICiAjZGVmaW5lIF9BU01fWFRFTlNBX0RFVklDRV9ICiAKLXN0cnVjdCBkbWFfbWFw
X29wczsKLQogc3RydWN0IGRldl9hcmNoZGF0YSB7Ci0JLyogRE1BIG9wZXJhdGlvbnMgb24gdGhh
dCBkZXZpY2UgKi8KLQljb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmRtYV9vcHM7CiB9OwogCiBz
dHJ1Y3QgcGRldl9hcmNoZGF0YSB7CmRpZmYgLS1naXQgYS9hcmNoL3h0ZW5zYS9pbmNsdWRlL2Fz
bS9kbWEtbWFwcGluZy5oIGIvYXJjaC94dGVuc2EvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApp
bmRleCA1MGQyMzEwNmNjZTAuLjllZWNmYzNjNWRjNCAxMDA2NDQKLS0tIGEvYXJjaC94dGVuc2Ev
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL3h0ZW5zYS9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCkBAIC0yMiw4ICsyMiw4IEBAIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX21h
cF9vcHMgeHRlbnNhX2RtYV9tYXBfb3BzOwogCiBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBk
bWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQogewotCWlmIChkZXYg
JiYgZGV2LT5hcmNoZGF0YS5kbWFfb3BzKQotCQlyZXR1cm4gZGV2LT5hcmNoZGF0YS5kbWFfb3Bz
OworCWlmIChkZXYgJiYgZGV2LT5kbWFfb3BzKQorCQlyZXR1cm4gZGV2LT5kbWFfb3BzOwogCWVs
c2UKIAkJcmV0dXJuICZ4dGVuc2FfZG1hX21hcF9vcHM7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9z
cnB0L2liX3NycHQuYwppbmRleCAzZmMzZjhiNTc1MmIuLjdmZjlkZTA2M2M1MyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnB0L2liX3NycHQuYworKysgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC5jCkBAIC0yNTI0LDcgKzI1MjQsNyBAQCBzdGF0aWMg
dm9pZCBzcnB0X2FkZF9vbmUoc3RydWN0IGliX2RldmljZSAqZGV2aWNlKQogCWludCBpOwogCiAJ
cHJfZGVidWcoImRldmljZSA9ICVwLCBkZXZpY2UtPmRtYV9vcHMgPSAlcFxuIiwgZGV2aWNlLAot
CQkgZGV2aWNlLT5kbWFfb3BzKTsKKwkJIGRldmljZS0+ZG1hX2RldmljZS0+ZG1hX29wcyk7CiAK
IAlzZGV2ID0ga3phbGxvYyhzaXplb2YoKnNkZXYpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIXNkZXYp
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9h
bWRfaW9tbXUuYwppbmRleCAzNzAzZmI5ZGI0MTkuLmY3Yjg2Njc5YmFmZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5j
CkBAIC01MTUsNyArNTE1LDcgQEAgc3RhdGljIHZvaWQgaW9tbXVfdW5pbml0X2RldmljZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCiAJaW9tbXVfZ3JvdXBfcmVtb3ZlX2RldmljZShkZXYpOwogCiAJLyog
UmVtb3ZlIGRtYS1vcHMgKi8KLQlkZXYtPmFyY2hkYXRhLmRtYV9vcHMgPSBOVUxMOworCWRldi0+
ZG1hX29wcyA9IE5VTEw7CiAKIAkvKgogCSAqIFdlIGtlZXAgZGV2X2RhdGEgYXJvdW5kIGZvciB1
bnBsdWdnZWQgZGV2aWNlcyBhbmQgcmV1c2UgaXQgd2hlbiB0aGUKQEAgLTIxNjQsNyArMjE2NCw3
IEBAIHN0YXRpYyBpbnQgYW1kX2lvbW11X2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQog
CQkJCWRldl9uYW1lKGRldikpOwogCiAJCWlvbW11X2lnbm9yZV9kZXZpY2UoZGV2KTsKLQkJZGV2
LT5hcmNoZGF0YS5kbWFfb3BzID0gJm5vbW11X2RtYV9vcHM7CisJCWRldi0+ZG1hX29wcyA9ICZu
b21tdV9kbWFfb3BzOwogCQlnb3RvIG91dDsKIAl9CiAJaW5pdF9pb21tdV9ncm91cChkZXYpOwpA
QCAtMjE4MSw3ICsyMTgxLDcgQEAgc3RhdGljIGludCBhbWRfaW9tbXVfYWRkX2RldmljZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCiAJaWYgKGRvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJ
VFkpCiAJCWRldl9kYXRhLT5wYXNzdGhyb3VnaCA9IHRydWU7CiAJZWxzZQotCQlkZXYtPmFyY2hk
YXRhLmRtYV9vcHMgPSAmYW1kX2lvbW11X2RtYV9vcHM7CisJCWRldi0+ZG1hX29wcyA9ICZhbWRf
aW9tbXVfZG1hX29wczsKIAogb3V0OgogCWlvbW11X2NvbXBsZXRpb25fd2FpdChpb21tdSk7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWljL2J1cy9taWNfYnVzLmMgYi9kcml2ZXJzL21pc2Mv
bWljL2J1cy9taWNfYnVzLmMKaW5kZXggYzRiMjdhMjU2NjJhLi43N2IxNmNhNjY4NDYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbWlzYy9taWMvYnVzL21pY19idXMuYworKysgYi9kcml2ZXJzL21pc2Mv
bWljL2J1cy9taWNfYnVzLmMKQEAgLTE1OCw3ICsxNTgsNyBAQCBtYnVzX3JlZ2lzdGVyX2Rldmlj
ZShzdHJ1Y3QgZGV2aWNlICpwZGV2LCBpbnQgaWQsIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAq
ZG1hXwogCW1iZGV2LT5kZXYucGFyZW50ID0gcGRldjsKIAltYmRldi0+aWQuZGV2aWNlID0gaWQ7
CiAJbWJkZXYtPmlkLnZlbmRvciA9IE1CVVNfREVWX0FOWV9JRDsKLQltYmRldi0+ZGV2LmFyY2hk
YXRhLmRtYV9vcHMgPSBkbWFfb3BzOworCW1iZGV2LT5kZXYuZG1hX29wcyA9IGRtYV9vcHM7CiAJ
bWJkZXYtPmRldi5kbWFfbWFzayA9ICZtYmRldi0+ZGV2LmNvaGVyZW50X2RtYV9tYXNrOwogCWRt
YV9zZXRfbWFzaygmbWJkZXYtPmRldiwgRE1BX0JJVF9NQVNLKDY0KSk7CiAJbWJkZXYtPmRldi5y
ZWxlYXNlID0gbWJ1c19yZWxlYXNlX2RldjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9taWMv
YnVzL3NjaWZfYnVzLmMgYi9kcml2ZXJzL21pc2MvbWljL2J1cy9zY2lmX2J1cy5jCmluZGV4IGU1
ZDM3N2U5N2M4Ni4uYTQ0NGRiNWY2MWZlIDEwMDY0NAotLS0gYS9kcml2ZXJzL21pc2MvbWljL2J1
cy9zY2lmX2J1cy5jCisrKyBiL2RyaXZlcnMvbWlzYy9taWMvYnVzL3NjaWZfYnVzLmMKQEAgLTE1
NCw3ICsxNTQsNyBAQCBzY2lmX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgZGV2aWNlICpwZGV2LCBp
bnQgaWQsIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hXwogCXNkZXYtPmRldi5wYXJlbnQg
PSBwZGV2OwogCXNkZXYtPmlkLmRldmljZSA9IGlkOwogCXNkZXYtPmlkLnZlbmRvciA9IFNDSUZf
REVWX0FOWV9JRDsKLQlzZGV2LT5kZXYuYXJjaGRhdGEuZG1hX29wcyA9IGRtYV9vcHM7CisJc2Rl
di0+ZGV2LmRtYV9vcHMgPSBkbWFfb3BzOwogCXNkZXYtPmRldi5yZWxlYXNlID0gc2NpZl9yZWxl
YXNlX2RldjsKIAlzZGV2LT5od19vcHMgPSBod19vcHM7CiAJc2Rldi0+ZG5vZGUgPSBkbm9kZTsK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZGV2aWNlLmggYi9pbmNsdWRlL2xpbnV4L2Rldmlj
ZS5oCmluZGV4IDQ5MWI0YzBjYTYzMy4uNDZhNTY3MjYxY2NjIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L2RldmljZS5oCisrKyBiL2luY2x1ZGUvbGludXgvZGV2aWNlLmgKQEAgLTkyMSw2ICs5
MjEsNyBAQCBzdHJ1Y3QgZGV2aWNlIHsKICNpZmRlZiBDT05GSUdfTlVNQQogCWludAkJbnVtYV9u
b2RlOwkvKiBOVU1BIG5vZGUgdGhpcyBkZXZpY2UgaXMgY2xvc2UgdG8gKi8KICNlbmRpZgorCWNv
bnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29wczsKIAl1NjQJCSpkbWFfbWFzazsJLyogZG1h
IG1hc2sgKGlmIGRtYSdhYmxlIGRldmljZSkgKi8KIAl1NjQJCWNvaGVyZW50X2RtYV9tYXNrOy8q
IExpa2UgZG1hX21hc2ssIGJ1dCBmb3IKIAkJCQkJICAgICBhbGxvY19jb2hlcmVudCBtYXBwaW5n
cyBhcwotLSAKMi4xMS4wCgo=

--_004_1484173670261928camelsandiskcom_
Content-Type: text/x-patch;
	name="0002-treewide-Consolidate-set_dma_ops-implementations.patch"
Content-Description: 0002-treewide-Consolidate-set_dma_ops-implementations.patch
Content-Disposition: attachment;
	filename="0002-treewide-Consolidate-set_dma_ops-implementations.patch";
	size=2885; creation-date="Wed, 11 Jan 2017 22:28:04 GMT";
	modification-date="Wed, 11 Jan 2017 22:28:04 GMT"
Content-ID: <2596F054D7B08B41AD187EA0CCE90678@sandisk.com>
Content-Transfer-Encoding: base64

RnJvbSA4M2I1ZDVjNjJhMmUwMmIwYjE3ODgwYzA0NGI1NzQ4NTMxZDdkMjcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHNhbmRp
c2suY29tPgpEYXRlOiBXZWQsIDExIEphbiAyMDE3IDEzOjQwOjU0IC0wODAwClN1YmplY3Q6IFtQ
QVRDSCAyLzNdIHRyZWV3aWRlOiBDb25zb2xpZGF0ZSBzZXRfZG1hX29wcygpIGltcGxlbWVudGF0
aW9ucwoKTm93IHRoYXQgYWxsIHNldF9kbWFfb3BzKCkgaW1wbGVtZW50YXRpb25zIGFyZSBpZGVu
dGljYWwsIHJlbW92ZQp0aGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluaXRpb25zIGFuZCBh
ZGQgYSBkZWZpbml0aW9uIGluCjxsaW51eC9kbWEtbWFwcGluZy5oPi4KClNpZ25lZC1vZmYtYnk6
IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAc2FuZGlzay5jb20+Ci0tLQogYXJjaC9h
cm0vaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCAgICAgfCA2IC0tLS0tLQogYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggfCA1IC0tLS0tCiBhcmNoL3RpbGUvaW5jbHVkZS9h
c20vZG1hLW1hcHBpbmcuaCAgICB8IDUgLS0tLS0KIGluY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcu
aCAgICAgICAgICAgIHwgNSArKysrKwogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmggYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IDMxMmY0
ZDA1NjRkNi4uYzc0MzJkNjQ3ZTUzIDEwMDY0NAotLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAg
LTMxLDEyICszMSw2IEBAIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpn
ZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCXJldHVybiBfX2dlbmVyaWNfZG1hX29w
cyhkZXYpOwogfQogCi1zdGF0aWMgaW5saW5lIHZvaWQgc2V0X2RtYV9vcHMoc3RydWN0IGRldmlj
ZSAqZGV2LCBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKm9wcykKLXsKLQlCVUdfT04oIWRldik7
Ci0JZGV2LT5kbWFfb3BzID0gb3BzOwotfQotCiAjZGVmaW5lIEhBVkVfQVJDSF9ETUFfU1VQUE9S
VEVEIDEKIGV4dGVybiBpbnQgZG1hX3N1cHBvcnRlZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBt
YXNrKTsKIApkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5n
LmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCA1OWZiZDRh
YmNiZjguLjgyNzU2MDNiYTRkNSAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNt
L2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5n
LmgKQEAgLTkxLDExICs5MSw2IEBAIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBf
b3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJcmV0dXJuIGRldi0+ZG1hX29w
czsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIHNldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRl
diwgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpvcHMpCi17Ci0JZGV2LT5kbWFfb3BzID0gb3Bz
OwotfQotCiAvKgogICogZ2V0X2RtYV9vZmZzZXQoKQogICoKZGlmZiAtLWdpdCBhL2FyY2gvdGls
ZS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC90aWxlL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmgKaW5kZXggYzA2MjA2OTdlYWFkLi4yNTYyOTk1YTZhYzkgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvdGlsZS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisrKyBiL2FyY2gvdGlsZS9pbmNsdWRl
L2FzbS9kbWEtbWFwcGluZy5oCkBAIC01OSwxMSArNTksNiBAQCBzdGF0aWMgaW5saW5lIHBoeXNf
YWRkcl90IGRtYV90b19waHlzKHN0cnVjdCBkZXZpY2UgKmRldiwgZG1hX2FkZHJfdCBkYWRkcikK
IAogc3RhdGljIGlubGluZSB2b2lkIGRtYV9tYXJrX2NsZWFuKHZvaWQgKmFkZHIsIHNpemVfdCBz
aXplKSB7fQogCi1zdGF0aWMgaW5saW5lIHZvaWQgc2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAq
ZGV2LCBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKm9wcykKLXsKLQlkZXYtPmRtYV9vcHMgPSBv
cHM7Ci19Ci0KIHN0YXRpYyBpbmxpbmUgYm9vbCBkbWFfY2FwYWJsZShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIGRtYV9hZGRyX3QgYWRkciwgc2l6ZV90IHNpemUpCiB7CiAJaWYgKCFkZXYtPmRtYV9tYXNr
KQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oIGIvaW5jbHVkZS9saW51
eC9kbWEtbWFwcGluZy5oCmluZGV4IGYxZGE2OGI4MmM2My4uZTk3ZjIzZThiMmQ5IDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKKysrIGIvaW5jbHVkZS9saW51eC9kbWEt
bWFwcGluZy5oCkBAIC0xNjQsNiArMTY0LDExIEBAIGludCBkbWFfbW1hcF9mcm9tX2NvaGVyZW50
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAKICNpZmRl
ZiBDT05GSUdfSEFTX0RNQQogI2luY2x1ZGUgPGFzbS9kbWEtbWFwcGluZy5oPgorc3RhdGljIGlu
bGluZSB2b2lkIHNldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCSAgICAgICBjb25z
dCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmRtYV9vcHMpCit7CisJZGV2LT5kbWFfb3BzID0gZG1hX29w
czsKK30KICNlbHNlCiAvKgogICogRGVmaW5lIHRoZSBkbWEgYXBpIHRvIGFsbG93IGNvbXBpbGF0
aW9uIGJ1dCBub3QgbGlua2luZyBvZgotLSAKMi4xMS4wCgo=

--_004_1484173670261928camelsandiskcom_
Content-Type: text/x-patch;
	name="0003-treewide-Consolidate-get_dma_ops-implementations.patch"
Content-Description: 0003-treewide-Consolidate-get_dma_ops-implementations.patch
Content-Disposition: attachment;
	filename="0003-treewide-Consolidate-get_dma_ops-implementations.patch";
	size=19530; creation-date="Wed, 11 Jan 2017 22:28:04 GMT";
	modification-date="Wed, 11 Jan 2017 22:28:04 GMT"
Content-ID: <46C701ABFA59F74C819FD10C9CC53DE2@sandisk.com>
Content-Transfer-Encoding: base64

RnJvbSA5OTc4OGU5NzkzN2QzZjcyOTk0N2NkMDJlOTg0NTdkNjQyYjhmMTE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHNhbmRp
c2suY29tPgpEYXRlOiBXZWQsIDExIEphbiAyMDE3IDEzOjQ5OjA4IC0wODAwClN1YmplY3Q6IFtQ
QVRDSCAzLzNdIHRyZWV3aWRlOiBDb25zb2xpZGF0ZSBnZXRfZG1hX29wcygpIGltcGxlbWVudGF0
aW9ucwoKSW50cm9kdWNlIGEgbmV3IGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBnZXRfYXJjaF9kbWFf
b3BzKCkgZnVuY3Rpb24uCkFkZCBnZXRfZG1hX29wcygpIGluIDxsaW51eC9kbWEtbWFwcGluZy5o
Pi4KClNpZ25lZC1vZmYtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3NjaGVAc2FuZGlz
ay5jb20+Ci0tLQogYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgfCAy
ICstCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgICB8IDIgKy0KIGFy
Y2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggICAgICAgIHwgNCArKy0tCiBhcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggICAgICB8IDQgKystLQogYXJjaC9hdnIzMi9p
bmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgfCAyICstCiBhcmNoL2JsYWNrZmluL2luY2x1
ZGUvYXNtL2RtYS1tYXBwaW5nLmggICB8IDIgKy0KIGFyY2gvYzZ4L2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmggICAgICAgIHwgMiArLQogYXJjaC9jcmlzL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5n
LmggICAgICAgfCA0ICsrLS0KIGFyY2gvZnJ2L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggICAg
ICAgIHwgMiArLQogYXJjaC9oODMwMC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgfCAy
ICstCiBhcmNoL2hleGFnb24vaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCAgICB8IDUgKy0tLS0K
IGFyY2gvaWE2NC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgIHwgNSArKysrLQogYXJj
aC9tMzJyL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggICAgICAgfCA0ICstLS0KIGFyY2gvbTY4
ay9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgIHwgMiArLQogYXJjaC9tZXRhZy9pbmNs
dWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgfCAyICstCiBhcmNoL21pY3JvYmxhemUvaW5jbHVk
ZS9hc20vZG1hLW1hcHBpbmcuaCB8IDIgKy0KIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9kbWEtbWFw
cGluZy5oICAgICAgIHwgNyArKy0tLS0tCiBhcmNoL21uMTAzMDAvaW5jbHVkZS9hc20vZG1hLW1h
cHBpbmcuaCAgICB8IDIgKy0KIGFyY2gvbmlvczIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCAg
ICAgIHwgMiArLQogYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgfCAy
ICstCiBhcmNoL3BhcmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICB8IDIgKy0KIGFy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgIHwgNyArKy0tLS0tCiBhcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vcHMzLmggICAgICAgICAgICB8IDIgKy0KIGFyY2gvczM5MC9p
bmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAgICAgIHwgNCArLS0tCiBhcmNoL3NoL2luY2x1ZGUv
YXNtL2RtYS1tYXBwaW5nLmggICAgICAgICB8IDIgKy0KIGFyY2gvc3BhcmMvaW5jbHVkZS9hc20v
ZG1hLW1hcHBpbmcuaCAgICAgIHwgNCArKy0tCiBhcmNoL3RpbGUvaW5jbHVkZS9hc20vZG1hLW1h
cHBpbmcuaCAgICAgICB8IDcgKystLS0tLQogYXJjaC91bmljb3JlMzIvaW5jbHVkZS9hc20vZG1h
LW1hcHBpbmcuaCAgfCAyICstCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oICAg
ICAgICB8IDkgKy0tLS0tLS0tCiBhcmNoL3h0ZW5zYS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5o
ICAgICB8IDcgKystLS0tLQogaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oICAgICAgICAgICAg
ICAgfCA3ICsrKysrKysKIDMxIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDY0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYWxwaGEvaW5jbHVkZS9hc20vZG1hLW1hcHBp
bmcuaCBiL2FyY2gvYWxwaGEvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCBkMzQ4MDU2
MjQxMWQuLjVkNTM2NjY5MzVlNiAxMDA2NDQKLS0tIGEvYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCisrKyBiL2FyY2gvYWxwaGEvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApA
QCAtMyw3ICszLDcgQEAKIAogZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29w
czsKIAotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3Bz
KHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBf
b3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVjdCBidXNfdHlwZSAqYnVzKQogewogCXJldHVybiBk
bWFfb3BzOwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcu
aCBiL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggZmRmZjNhYTYwMDUy
Li45NDI4NTAzMWM0ZmIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2RtYS1tYXBw
aW5nLmgKKysrIGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMjAsNyAr
MjAsNyBAQAogCiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIGFyY19kbWFfb3BzOwog
Ci1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3Ry
dWN0IGRldmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMg
KmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7CiAJcmV0dXJuICZhcmNf
ZG1hX29wczsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5n
LmggYi9hcmNoL2FybS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IGM3NDMyZDY0N2U1
My4uNzE2NjU2OTI1OTc1IDEwMDY0NAotLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9kbWEtbWFw
cGluZy5oCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTIzLDEy
ICsyMywxMiBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqX19nZW5l
cmljX2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQogCXJldHVybiAmYXJtX2RtYV9vcHM7CiB9
CiAKLXN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhz
dHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29w
cyAqZ2V0X2FyY2hfZG1hX29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIHsKIAlpZiAoeGVuX2lu
aXRpYWxfZG9tYWluKCkpCiAJCXJldHVybiB4ZW5fZG1hX29wczsKIAllbHNlCi0JCXJldHVybiBf
X2dlbmVyaWNfZG1hX29wcyhkZXYpOworCQlyZXR1cm4gX19nZW5lcmljX2RtYV9vcHMoTlVMTCk7
CiB9CiAKICNkZWZpbmUgSEFWRV9BUkNIX0RNQV9TVVBQT1JURUQgMQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9kbWEtbWFwcGluZy5oCmluZGV4IDU4YWUzNmNjM2I2MC4uNTA1NzU2Y2RjNjdhIDEwMDY0NAot
LS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9hcm02
NC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0zOSwxMiArMzksMTIgQEAgc3RhdGljIGlu
bGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKl9fZ2VuZXJpY19kbWFfb3BzKHN0cnVjdCBk
ZXZpY2UgKmRldikKIAlyZXR1cm4gJmR1bW15X2RtYV9vcHM7CiB9CiAKLXN0YXRpYyBpbmxpbmUg
Y29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYp
CitzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2FyY2hfZG1hX29w
cyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIHsKIAlpZiAoeGVuX2luaXRpYWxfZG9tYWluKCkpCiAJ
CXJldHVybiB4ZW5fZG1hX29wczsKIAllbHNlCi0JCXJldHVybiBfX2dlbmVyaWNfZG1hX29wcyhk
ZXYpOworCQlyZXR1cm4gX19nZW5lcmljX2RtYV9vcHMoTlVMTCk7CiB9CiAKIHZvaWQgYXJjaF9z
ZXR1cF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IGRtYV9iYXNlLCB1NjQgc2l6ZSwK
ZGlmZiAtLWdpdCBhL2FyY2gvYXZyMzIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gv
YXZyMzIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCBiMmI0M2MwZTA3NzQuLjczODg0
NTFmOTkwNSAxMDA2NDQKLS0tIGEvYXJjaC9hdnIzMi9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5o
CisrKyBiL2FyY2gvYXZyMzIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtNiw3ICs2LDcg
QEAgZXh0ZXJuIHZvaWQgZG1hX2NhY2hlX3N5bmMoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICp2
YWRkciwgc2l6ZV90IHNpemUsCiAKIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgYXZy
MzJfZG1hX29wczsKIAotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdl
dF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0
IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVjdCBidXNfdHlwZSAqYnVzKQogewog
CXJldHVybiAmYXZyMzJfZG1hX29wczsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvYmxhY2tmaW4vaW5j
bHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvYmxhY2tmaW4vaW5jbHVkZS9hc20vZG1hLW1h
cHBpbmcuaAppbmRleCAzMjBmYjUwZmJkNDEuLjA0MjU0YWMzNmJlZCAxMDA2NDQKLS0tIGEvYXJj
aC9ibGFja2Zpbi9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisrKyBiL2FyY2gvYmxhY2tmaW4v
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMzgsNyArMzgsNyBAQCBfZG1hX3N5bmMoZG1h
X2FkZHJfdCBhZGRyLCBzaXplX3Qgc2l6ZSwgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyKQog
CiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIGJmaW5fZG1hX29wczsKIAotc3RhdGlj
IGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZp
Y2UgKmRldikKK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJj
aF9kbWFfb3BzKHN0cnVjdCBidXNfdHlwZSAqYnVzKQogewogCXJldHVybiAmYmZpbl9kbWFfb3Bz
OwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9jNngvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2Fy
Y2gvYzZ4L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggODgyNThiOWViYzhlLi5hY2E5
Zjc1NWU0ZjggMTAwNjQ0Ci0tLSBhL2FyY2gvYzZ4L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
KysrIGIvYXJjaC9jNngvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMTksNyArMTksNyBA
QAogCiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIGM2eF9kbWFfb3BzOwogCi1zdGF0
aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRl
dmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9h
cmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7CiAJcmV0dXJuICZjNnhfZG1hX29w
czsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvY3Jpcy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIv
YXJjaC9jcmlzL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggYWFlNGZiYzBhNjU2Li4y
NTYxNjlkZTM3NDMgMTAwNjQ0Ci0tLSBhL2FyY2gvY3Jpcy9pbmNsdWRlL2FzbS9kbWEtbWFwcGlu
Zy5oCisrKyBiL2FyY2gvY3Jpcy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC00LDEyICs0
LDEyIEBACiAjaWZkZWYgQ09ORklHX1BDSQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29w
cyB2MzJfZG1hX29wczsKIAotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMg
KmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3Ry
dWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVjdCBidXNfdHlwZSAqYnVzKQog
ewogCXJldHVybiAmdjMyX2RtYV9vcHM7CiB9CiAjZWxzZQotc3RhdGljIGlubGluZSBjb25zdCBz
dHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRp
YyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVj
dCBidXNfdHlwZSAqYnVzKQogewogCUJVRygpOwogCXJldHVybiBOVUxMOwpkaWZmIC0tZ2l0IGEv
YXJjaC9mcnYvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvZnJ2L2luY2x1ZGUvYXNt
L2RtYS1tYXBwaW5nLmgKaW5kZXggMTUwY2MwMDU0NGE4Li4zNTQ5MDA5MTc1ODUgMTAwNjQ0Ci0t
LSBhL2FyY2gvZnJ2L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9mcnYvaW5j
bHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtOSw3ICs5LDcgQEAgZXh0ZXJuIHVuc2lnbmVkIGxv
bmcgX19ub25ncHJlbGJzcyBkbWFfY29oZXJlbnRfbWVtX2VuZDsKIAogZXh0ZXJuIGNvbnN0IHN0
cnVjdCBkbWFfbWFwX29wcyBmcnZfZG1hX29wczsKIAotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1
Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRpYyBp
bmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVjdCBi
dXNfdHlwZSAqYnVzKQogewogCXJldHVybiAmZnJ2X2RtYV9vcHM7CiB9CmRpZmYgLS1naXQgYS9h
cmNoL2g4MzAwL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL2g4MzAwL2luY2x1ZGUv
YXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggZjgwNGJjYTRjMTNmLi44NDdjNzU2MmUwNDYgMTAwNjQ0
Ci0tLSBhL2FyY2gvaDgzMDAvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL2g4
MzAwL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTMsNyArMyw3IEBACiAKIGV4dGVybiBj
b25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgaDgzMDBfZG1hX21hcF9vcHM7CiAKLXN0YXRpYyBpbmxp
bmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpk
ZXYpCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2FyY2hfZG1h
X29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIHsKIAlyZXR1cm4gJmg4MzAwX2RtYV9tYXBfb3Bz
OwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgg
Yi9hcmNoL2hleGFnb24vaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCBiODEyZTkxN2Nk
OTUuLmQzYTg3YmQ5YjY4NiAxMDA2NDQKLS0tIGEvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2Rt
YS1tYXBwaW5nLmgKKysrIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
QEAgLTM0LDExICszNCw4IEBAIGV4dGVybiBpbnQgYmFkX2RtYV9hZGRyZXNzOwogCiBleHRlcm4g
Y29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpkbWFfb3BzOwogCi1zdGF0aWMgaW5saW5lIGNvbnN0
IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQorc3Rh
dGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3Ry
dWN0IGJ1c190eXBlICpidXMpCiB7Ci0JaWYgKHVubGlrZWx5KGRldiA9PSBOVUxMKSkKLQkJcmV0
dXJuIE5VTEw7Ci0KIAlyZXR1cm4gZG1hX29wczsKIH0KIApkaWZmIC0tZ2l0IGEvYXJjaC9pYTY0
L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL2lhNjQvaW5jbHVkZS9hc20vZG1hLW1h
cHBpbmcuaAppbmRleCAwNWU0NjdkNTZkODYuLjczZWMzYzZmNGNmZSAxMDA2NDQKLS0tIGEvYXJj
aC9pYTY0L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9pYTY0L2luY2x1ZGUv
YXNtL2RtYS1tYXBwaW5nLmgKQEAgLTIzLDcgKzIzLDEwIEBAIGV4dGVybiB2b2lkIG1hY2h2ZWNf
ZG1hX3N5bmNfc2luZ2xlKHN0cnVjdCBkZXZpY2UgKiwgZG1hX2FkZHJfdCwgc2l6ZV90LAogZXh0
ZXJuIHZvaWQgbWFjaHZlY19kbWFfc3luY19zZyhzdHJ1Y3QgZGV2aWNlICosIHN0cnVjdCBzY2F0
dGVybGlzdCAqLCBpbnQsCiAJCQkJZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24pOwogCi0jZGVmaW5l
IGdldF9kbWFfb3BzKGRldikgcGxhdGZvcm1fZG1hX2dldF9vcHMoZGV2KQorc3RhdGljIGlubGlu
ZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190
eXBlICpidXMpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RtYV9nZXRfb3BzKE5VTEwpOworfQogCiBz
dGF0aWMgaW5saW5lIGJvb2wgZG1hX2NhcGFibGUoc3RydWN0IGRldmljZSAqZGV2LCBkbWFfYWRk
cl90IGFkZHIsIHNpemVfdCBzaXplKQogewpkaWZmIC0tZ2l0IGEvYXJjaC9tMzJyL2luY2x1ZGUv
YXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL20zMnIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApp
bmRleCAyN2IxNTk3YWM1NjMuLmMwMWQ5ZjUyZDIyOCAxMDA2NDQKLS0tIGEvYXJjaC9tMzJyL2lu
Y2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9tMzJyL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmgKQEAgLTEwLDEwICsxMCw4IEBACiAKICNkZWZpbmUgRE1BX0VSUk9SX0NPREUgKH4o
ZG1hX2FkZHJfdCkweDApCiAKLXN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3Bz
ICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0
cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2FyY2hfZG1hX29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykK
IHsKLQlpZiAoZGV2ICYmIGRldi0+ZG1hX29wcykKLQkJcmV0dXJuIGRldi0+ZG1hX29wczsKIAly
ZXR1cm4gJmRtYV9ub29wX29wczsKIH0KIApkaWZmIC0tZ2l0IGEvYXJjaC9tNjhrL2luY2x1ZGUv
YXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL202OGsvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApp
bmRleCA4NjM1MDk5MzlkNWEuLjkyMTBlNDcwNzcxYiAxMDA2NDQKLS0tIGEvYXJjaC9tNjhrL2lu
Y2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9tNjhrL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmgKQEAgLTMsNyArMyw3IEBACiAKIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX21hcF9v
cHMgbTY4a19kbWFfb3BzOwogCi1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29w
cyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBz
dHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMp
CiB7CiAgICAgICAgIHJldHVybiAmbTY4a19kbWFfb3BzOwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9t
ZXRhZy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9tZXRhZy9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCmluZGV4IGMxNTZhN2FjNzMyZi4uZmFkM2RjM2NiMjEwIDEwMDY0NAotLS0g
YS9hcmNoL21ldGFnL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9tZXRhZy9p
bmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0zLDcgKzMsNyBAQAogCiBleHRlcm4gY29uc3Qg
c3RydWN0IGRtYV9tYXBfb3BzIG1ldGFnX2RtYV9vcHM7CiAKLXN0YXRpYyBpbmxpbmUgY29uc3Qg
c3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0
aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2FyY2hfZG1hX29wcyhzdHJ1
Y3QgYnVzX3R5cGUgKmJ1cykKIHsKIAlyZXR1cm4gJm1ldGFnX2RtYV9vcHM7CiB9CmRpZmYgLS1n
aXQgYS9hcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvbWlj
cm9ibGF6ZS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IGM3ZmFmMmZiNTFkNi4uM2Zh
ZDVlNzIyYTY2IDEwMDY0NAotLS0gYS9hcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vZG1hLW1h
cHBpbmcuaAorKysgYi9hcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApA
QCAtMzgsNyArMzgsNyBAQAogICovCiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIGRt
YV9kaXJlY3Rfb3BzOwogCi1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAq
Z2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1
Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7
CiAJcmV0dXJuICZkbWFfZGlyZWN0X29wczsKIH0KZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9pbmNs
dWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5n
LmgKaW5kZXggZGFkM2IwOWZlOTkzLi5hYmE3MTM4NWY5ZDEgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlw
cy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisrKyBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCkBAIC0xMSwxMiArMTEsOSBAQAogCiBleHRlcm4gY29uc3Qgc3RydWN0IGRt
YV9tYXBfb3BzICptaXBzX2RtYV9tYXBfb3BzOwogCi1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVj
dCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIGlu
bGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1
c190eXBlICpidXMpCiB7Ci0JaWYgKGRldiAmJiBkZXYtPmRtYV9vcHMpCi0JCXJldHVybiBkZXYt
PmRtYV9vcHM7Ci0JZWxzZQotCQlyZXR1cm4gbWlwc19kbWFfbWFwX29wczsKKwlyZXR1cm4gbWlw
c19kbWFfbWFwX29wczsKIH0KIAogc3RhdGljIGlubGluZSBib29sIGRtYV9jYXBhYmxlKHN0cnVj
dCBkZXZpY2UgKmRldiwgZG1hX2FkZHJfdCBhZGRyLCBzaXplX3Qgc2l6ZSkKZGlmZiAtLWdpdCBh
L2FyY2gvbW4xMDMwMC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9tbjEwMzAwL2lu
Y2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggNTY0ZTM5MjdlMDA1Li43MzdlZjU3NGIzZWEg
MTAwNjQ0Ci0tLSBhL2FyY2gvbW4xMDMwMC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisrKyBi
L2FyY2gvbW4xMDMwMC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0xNiw3ICsxNiw3IEBA
CiAKIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgbW4xMDMwMF9kbWFfb3BzOwogCi1z
dGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0
IGRldmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdl
dF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7CiAJcmV0dXJuICZtbjEwMzAw
X2RtYV9vcHM7CiB9CmRpZmYgLS1naXQgYS9hcmNoL25pb3MyL2luY2x1ZGUvYXNtL2RtYS1tYXBw
aW5nLmggYi9hcmNoL25pb3MyL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggYWEwMGQ4
MzlhNjRiLi43YjNjNmYyODAyOTMgMTAwNjQ0Ci0tLSBhL2FyY2gvbmlvczIvaW5jbHVkZS9hc20v
ZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL25pb3MyL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
QEAgLTEyLDcgKzEyLDcgQEAKIAogZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyBuaW9z
Ml9kbWFfb3BzOwogCi1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0
X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3Qg
ZG1hX21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7CiAJ
cmV0dXJuICZuaW9zMl9kbWFfb3BzOwogfQpkaWZmIC0tZ2l0IGEvYXJjaC9vcGVucmlzYy9pbmNs
dWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFw
cGluZy5oCmluZGV4IDg4YWNiZWRiNDk0Ny4uMGMwMDc1ZjE3MTQ1IDEwMDY0NAotLS0gYS9hcmNo
L29wZW5yaXNjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9vcGVucmlzYy9p
bmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0zMCw3ICszMCw3IEBACiAKIGV4dGVybiBjb25z
dCBzdHJ1Y3QgZG1hX21hcF9vcHMgb3Ixa19kbWFfbWFwX29wczsKIAotc3RhdGljIGlubGluZSBj
b25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikK
K3N0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3Bz
KHN0cnVjdCBidXNfdHlwZSAqYnVzKQogewogCXJldHVybiAmb3Ixa19kbWFfbWFwX29wczsKIH0K
ZGlmZiAtLWdpdCBhL2FyY2gvcGFyaXNjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9hcmNo
L3BhcmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IDE3NDkwNzNlNDRmYy4uNTQw
NGM2YTcyNmIyIDEwMDY0NAotLS0gYS9hcmNoL3BhcmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGlu
Zy5oCisrKyBiL2FyY2gvcGFyaXNjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTI3LDcg
KzI3LDcgQEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyBwY3hfZG1hX29wczsKIAog
ZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqaHBwYV9kbWFfb3BzOwogCi1zdGF0aWMg
aW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRldmlj
ZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNo
X2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7CiAJcmV0dXJuIGhwcGFfZG1hX29wczsK
IH0KZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIv
YXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggODI3NTYwM2JhNGQ1
Li4xODFhMDk1NDY4ZTQgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9kbWEt
bWFwcGluZy5oCisrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBA
IC03OCwxNyArNzgsMTQgQEAgZXh0ZXJuIHN0cnVjdCBkbWFfbWFwX29wcyBkbWFfaW9tbXVfb3Bz
OwogI2VuZGlmCiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIGRtYV9kaXJlY3Rfb3Bz
OwogCi1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMo
c3RydWN0IGRldmljZSAqZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9v
cHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7CiAJLyogV2UgZG9u
J3QgaGFuZGxlIHRoZSBOVUxMIGRldiBjYXNlIGZvciBJU0EgZm9yIG5vdy4gV2UgY291bGQKIAkg
KiBkbyBpdCB2aWEgYW4gb3V0IG9mIGxpbmUgY2FsbCBidXQgaXQgaXMgbm90IG5lZWRlZCBmb3Ig
bm93LiBUaGUKIAkgKiBvbmx5IElTQSBETUEgZGV2aWNlIHdlIHN1cHBvcnQgaXMgdGhlIGZsb3Bw
eSBhbmQgd2UgaGF2ZSBhIGhhY2sKIAkgKiBpbiB0aGUgZmxvcHB5IGRyaXZlciBkaXJlY3RseSB0
byBnZXQgYSBkZXZpY2UgZm9yIHVzLgogCSAqLwotCWlmICh1bmxpa2VseShkZXYgPT0gTlVMTCkp
Ci0JCXJldHVybiBOVUxMOwotCi0JcmV0dXJuIGRldi0+ZG1hX29wczsKKwlyZXR1cm4gTlVMTDsK
IH0KIAogLyoKZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wczMuaCBiL2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wczMuaAppbmRleCBhMTlmODMxYTRjYzkuLjE3ZWU3MTll
Nzk5ZiAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BzMy5oCisrKyBiL2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wczMuaApAQCAtNDM1LDcgKzQzNSw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCAqcHMzX3N5c3RlbV9idXNfZ2V0X2RydmRhdGEoCiAJcmV0dXJuIGRldl9nZXRf
ZHJ2ZGF0YSgmZGV2LT5jb3JlKTsKIH0KIAotLyogVGhlc2UgdHdvIG5lZWQgZ2xvYmFsIHNjb3Bl
IGZvciBnZXRfZG1hX29wcygpLiAqLworLyogVGhlc2UgdHdvIG5lZWQgZ2xvYmFsIHNjb3BlIGZv
ciBnZXRfYXJjaF9kbWFfb3BzKCkuICovCiAKIGV4dGVybiBzdHJ1Y3QgYnVzX3R5cGUgcHMzX3N5
c3RlbV9idXNfdHlwZTsKIApkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmggYi9hcmNoL3MzOTAvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCBhODcy
MDI3ZDBjMWIuLjMxMDhiOGRiZTI2NiAxMDA2NDQKLS0tIGEvYXJjaC9zMzkwL2luY2x1ZGUvYXNt
L2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9zMzkwL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
QEAgLTEyLDEwICsxMiw4IEBACiAKIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgczM5
MF9wY2lfZG1hX29wczsKIAotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMg
KmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRpYyBpbmxpbmUgY29uc3Qgc3Ry
dWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVjdCBidXNfdHlwZSAqYnVzKQog
ewotCWlmIChkZXYgJiYgZGV2LT5kbWFfb3BzKQotCQlyZXR1cm4gZGV2LT5kbWFfb3BzOwogCXJl
dHVybiAmZG1hX25vb3Bfb3BzOwogfQogCmRpZmYgLS1naXQgYS9hcmNoL3NoL2luY2x1ZGUvYXNt
L2RtYS1tYXBwaW5nLmggYi9hcmNoL3NoL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXgg
YTczODJjMzRjMjQxLi5kOTkwMDhhZjVmNzMgMTAwNjQ0Ci0tLSBhL2FyY2gvc2gvaW5jbHVkZS9h
c20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL3NoL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
QEAgLTQsNyArNCw3IEBACiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpkbWFfb3Bz
OwogZXh0ZXJuIHZvaWQgbm9faW9tbXVfaW5pdCh2b2lkKTsKIAotc3RhdGljIGlubGluZSBjb25z
dCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0
YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0
cnVjdCBidXNfdHlwZSAqYnVzKQogewogCXJldHVybiBkbWFfb3BzOwogfQpkaWZmIC0tZ2l0IGEv
YXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9zcGFyYy9pbmNsdWRl
L2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IDNkMmJhYmMwYzRjNi4uNjljYzYyNzc3OWYyIDEwMDY0
NAotLS0gYS9hcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9z
cGFyYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0yNCwxNCArMjQsMTQgQEAgZXh0ZXJu
IGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyBwY2kzMl9kbWFfb3BzOwogCiBleHRlcm4gc3RydWN0
IGJ1c190eXBlIHBjaV9idXNfdHlwZTsKIAotc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1h
X21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3N0YXRpYyBpbmxpbmUg
Y29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3BzKHN0cnVjdCBidXNfdHlw
ZSAqYnVzKQogewogI2lmZGVmIENPTkZJR19TUEFSQ19MRU9OCiAJaWYgKHNwYXJjX2NwdV9tb2Rl
bCA9PSBzcGFyY19sZW9uKQogCQlyZXR1cm4gbGVvbl9kbWFfb3BzOwogI2VuZGlmCiAjaWYgZGVm
aW5lZChDT05GSUdfU1BBUkMzMikgJiYgZGVmaW5lZChDT05GSUdfUENJKQotCWlmIChkZXYtPmJ1
cyA9PSAmcGNpX2J1c190eXBlKQorCWlmIChidXMgPT0gJnBjaV9idXNfdHlwZSkKIAkJcmV0dXJu
ICZwY2kzMl9kbWFfb3BzOwogI2VuZGlmCiAJcmV0dXJuIGRtYV9vcHM7CmRpZmYgLS1naXQgYS9h
cmNoL3RpbGUvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvdGlsZS9pbmNsdWRlL2Fz
bS9kbWEtbWFwcGluZy5oCmluZGV4IDI1NjI5OTVhNmFjOS4uYmJjNzFhMjliMmM2IDEwMDY0NAot
LS0gYS9hcmNoL3RpbGUvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL3RpbGUv
aW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMjksMTIgKzI5LDkgQEAgZXh0ZXJuIGNvbnN0
IHN0cnVjdCBkbWFfbWFwX29wcyAqZ3hfcGNpX2RtYV9tYXBfb3BzOwogZXh0ZXJuIGNvbnN0IHN0
cnVjdCBkbWFfbWFwX29wcyAqZ3hfbGVnYWN5X3BjaV9kbWFfbWFwX29wczsKIGV4dGVybiBjb25z
dCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmd4X2h5YnJpZF9wY2lfZG1hX21hcF9vcHM7CiAKLXN0YXRp
YyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2
aWNlICpkZXYpCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2Fy
Y2hfZG1hX29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIHsKLQlpZiAoZGV2ICYmIGRldi0+ZG1h
X29wcykKLQkJcmV0dXJuIGRldi0+ZG1hX29wczsKLQllbHNlCi0JCXJldHVybiB0aWxlX2RtYV9t
YXBfb3BzOworCXJldHVybiB0aWxlX2RtYV9tYXBfb3BzOwogfQogCiBzdGF0aWMgaW5saW5lIGRt
YV9hZGRyX3QgZ2V0X2RtYV9vZmZzZXQoc3RydWN0IGRldmljZSAqZGV2KQpkaWZmIC0tZ2l0IGEv
YXJjaC91bmljb3JlMzIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvdW5pY29yZTMy
L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKaW5kZXggMTRkNzcyOWM3YjczLi41MThiYTU4NDhk
ZDYgMTAwNjQ0Ci0tLSBhL2FyY2gvdW5pY29yZTMyL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
KysrIGIvYXJjaC91bmljb3JlMzIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtMjMsNyAr
MjMsNyBAQAogCiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzIHN3aW90bGJfZG1hX21h
cF9vcHM7CiAKLXN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfZG1h
X29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFf
bWFwX29wcyAqZ2V0X2FyY2hfZG1hX29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIHsKIAlyZXR1
cm4gJnN3aW90bGJfZG1hX21hcF9vcHM7CiB9CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaApp
bmRleCA5NGI1Yjk2OTY2Y2IuLjA4YTA4MzhiODNmYiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kbWEtbWFw
cGluZy5oCkBAIC0yNywxNiArMjcsOSBAQCBleHRlcm4gaW50IHBhbmljX29uX292ZXJmbG93Owog
CiBleHRlcm4gY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpkbWFfb3BzOwogCi1zdGF0aWMgaW5s
aW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAq
ZGV2KQorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmdldF9hcmNoX2Rt
YV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiB7Ci0jaWZuZGVmIENPTkZJR19YODZfREVWX0RN
QV9PUFMKIAlyZXR1cm4gZG1hX29wczsKLSNlbHNlCi0JaWYgKHVubGlrZWx5KCFkZXYpIHx8ICFk
ZXYtPmRtYV9vcHMpCi0JCXJldHVybiBkbWFfb3BzOwotCWVsc2UKLQkJcmV0dXJuIGRldi0+ZG1h
X29wczsKLSNlbmRpZgogfQogCiBib29sIGFyY2hfZG1hX2FsbG9jX2F0dHJzKHN0cnVjdCBkZXZp
Y2UgKipkZXYsIGdmcF90ICpnZnApOwpkaWZmIC0tZ2l0IGEvYXJjaC94dGVuc2EvaW5jbHVkZS9h
c20vZG1hLW1hcHBpbmcuaCBiL2FyY2gveHRlbnNhL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
aW5kZXggOWVlY2ZjM2M1ZGM0Li5jNjE0MGZhOGMwYmUgMTAwNjQ0Ci0tLSBhL2FyY2gveHRlbnNh
L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC94dGVuc2EvaW5jbHVkZS9hc20v
ZG1hLW1hcHBpbmcuaApAQCAtMjAsMTIgKzIwLDkgQEAKIAogZXh0ZXJuIGNvbnN0IHN0cnVjdCBk
bWFfbWFwX29wcyB4dGVuc2FfZG1hX21hcF9vcHM7CiAKLXN0YXRpYyBpbmxpbmUgY29uc3Qgc3Ry
dWN0IGRtYV9tYXBfb3BzICpnZXRfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMg
aW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2FyY2hfZG1hX29wcyhzdHJ1Y3Qg
YnVzX3R5cGUgKmJ1cykKIHsKLQlpZiAoZGV2ICYmIGRldi0+ZG1hX29wcykKLQkJcmV0dXJuIGRl
di0+ZG1hX29wczsKLQllbHNlCi0JCXJldHVybiAmeHRlbnNhX2RtYV9tYXBfb3BzOworCXJldHVy
biAmeHRlbnNhX2RtYV9tYXBfb3BzOwogfQogCiB2b2lkIGRtYV9jYWNoZV9zeW5jKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdm9pZCAqdmFkZHIsIHNpemVfdCBzaXplLApkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9kbWEtbWFwcGluZy5oIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCmluZGV4
IGU5N2YyM2U4YjJkOS4uYWI4NzEwODg4ZGRmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Rt
YS1tYXBwaW5nLmgKKysrIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCkBAIC0xNjQsNiAr
MTY0LDEzIEBAIGludCBkbWFfbW1hcF9mcm9tX2NvaGVyZW50KHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAKICNpZmRlZiBDT05GSUdfSEFTX0RNQQogI2lu
Y2x1ZGUgPGFzbS9kbWEtbWFwcGluZy5oPgorc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1h
X21hcF9vcHMgKmdldF9kbWFfb3BzKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlpZiAoZGV2ICYm
IGRldi0+ZG1hX29wcykKKwkJcmV0dXJuIGRldi0+ZG1hX29wczsKKwlyZXR1cm4gZ2V0X2FyY2hf
ZG1hX29wcyhkZXYgPyBkZXYtPmJ1cyA6IE5VTEwpOworfQorCiBzdGF0aWMgaW5saW5lIHZvaWQg
c2V0X2RtYV9vcHMoc3RydWN0IGRldmljZSAqZGV2LAogCQkJICAgICAgIGNvbnN0IHN0cnVjdCBk
bWFfbWFwX29wcyAqZG1hX29wcykKIHsKLS0gCjIuMTEuMAoK

--_004_1484173670261928camelsandiskcom_--
