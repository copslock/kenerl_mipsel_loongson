Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 01:57:45 +0100 (CET)
Received: from mail-co1nam03on0071.outbound.protection.outlook.com ([104.47.40.71]:32864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993875AbdAKA5J4aAEx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2017 01:57:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sandiskcorp.onmicrosoft.com; s=selector1-sandisk-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+HIhtPX0txq66G4QVhrYqMFz7SL0X1dvgxmYprBiHvY=;
 b=uteJ01Wp6ZwwKlR3WptxC1CaFaBvawjLgPBcZCPy2zq5oWD7dQWDxB4e3sPbeaxLRseG3Ky647ilj/MVSHqvF8/tgqO3LMiXodsMflyvuiBsSm1YHoxVUwRxUs1Vm/I7qJvQntj3iOxwPTsFDs2d5TgvNLepDGc3j49F1csfyas=
Received: from BY1PR0201CA0004.namprd02.prod.outlook.com (10.160.191.142) by
 BY2PR02MB1409.namprd02.prod.outlook.com (10.162.80.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.817.10; Wed, 11 Jan 2017 00:56:54 +0000
Received: from BY2FFO11FD042.protection.gbl (2a01:111:f400:7c0c::160) by
 BY1PR0201CA0004.outlook.office365.com (2a01:111:e400:4814::14) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.845.12 via
 Frontend Transport; Wed, 11 Jan 2017 00:56:54 +0000
Authentication-Results: spf=pass (sender IP is 63.163.107.21)
 smtp.mailfrom=sandisk.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=sandisk.com;
Received-SPF: Pass (protection.outlook.com: domain of sandisk.com designates
 63.163.107.21 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.163.107.21; helo=milsmgep15.sandisk.com;
Received: from milsmgep15.sandisk.com (63.163.107.21) by
 BY2FFO11FD042.mail.protection.outlook.com (10.1.14.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.803.8 via Frontend Transport; Wed, 11 Jan 2017 00:56:53 +0000
Received: from MILHUBIP03.sdcorp.global.sandisk.com (Unknown_Domain [10.201.67.162])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id CE.7A.65426.13085785; Tue, 10 Jan 2017 16:45:37 -0800 (PST)
Received: from milsmgip12.sandisk.com (10.177.9.6) by
 MILHUBIP03.sdcorp.global.sandisk.com (10.177.9.96) with Microsoft SMTP Server
 id 14.3.319.2; Tue, 10 Jan 2017 16:56:51 -0800
X-AuditID: 0ac94369-b62949800001ff92-ae-58758031aaa4
Received: from exp-402881.sdcorp.global.sandisk.com ( [10.177.8.100])   by
  (Symantec Messaging Gateway) with SMTP id 10.14.09762.3D285785; Tue, 10 Jan
 2017 16:56:51 -0800 (PST)
From:   Bart Van Assche <bart.vanassche@sandisk.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geoff Levand <geoff@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        "Hans-Christian Egtvedt" <egtvedt@samfundet.no>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Joerg Roedel <joro@8bytes.org>, Jon Mason <jdmason@kudzu.us>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Muli Ben-Yehuda <mulix@mulix.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <iommu@lists.linux-foundation.org>, <linux-alpha@vger.kernel.org>,
        <linux-am33-list@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-cris-kernel@axis.com>,
        <linux-hexagon@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-metag@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-parisc@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <linux-snps-arc@lists.infradead.org>,
        <linux-xtensa@linux-xtensa.org>, <linuxppc-dev@lists.ozlabs.org>,
        <nios2-dev@lists.rocketboards.org>,
        <openrisc@lists.librecores.org>, <sparclinux@vger.kernel.org>,
        <uclinux-h8-devel@lists.sourceforge.jp>
Subject: [PATCH 2/9] Move dma_ops from archdata into struct device
Date:   Tue, 10 Jan 2017 16:56:41 -0800
Message-ID: <20170111005648.14988-3-bart.vanassche@sandisk.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170111005648.14988-1-bart.vanassche@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG9//fl146au46Mv9hH0y6TY0GFOOSQyDiZkbuwpawL47InHZy
        gw2vaYEMky3dkM4WzZrGulBqaVEEKpSuHUshNEIxsqqAQuKmglVpeVFHK5v4UjNHbbb47Tnn
        /J7n+XI4St7KpnOqyhpRXaksV7BSWhrc1ZaRpa0t2jp0RgH6/rgERt1aFqJnjiJoautgwfH0
        GQPWicM0hJZvIlj6Pk7D4kSMgSbXXQnoTnwAczf8GE4v7oCGU70snPh5LTx51ECD/VwOrNxx
        IOie1LEQcjkZmA9YKHjeHMOgb3FLIGKcZmFp5jwCy7kZGjyz1xg432LE0HnWRUH0sI+F2JEl
        BqYGrCx0hHuo1aofaDCaTRK4e/EKhjHbKAtzgWOrO0cDBdbnxylonO7B0DXWI4GA2Y8g/vgf
        BiaH7Bhe/ORF0Dt8kwaDJcKCRz/Fgt98G4E22MnAYPwLGPN0YfB6zBQ8uHKLhr5LUQoWH/5G
        wxP3LAMhkx/vzBHCwzYsNPqNrNBt60bC1LWrlPC7q1D4pes6FvotMxIh9vBLwdu5STg1uIgF
        j1PPCvbeMCOMt8RoYWl8XCL4PPexEBg5ggrX75HmlojlqjpRvWXHfulBnamVrnYO4K91yyOM
        Fp00YANK4Qi/nczH2pEBSTk5347JdLuFSg6/InLvQfx/6rs/L9EJLee9iPw1kp3QLL+NrESb
        X+7T+PXEc69NkjBTfJAnx+afrsZy3Jv8h8TqS0swNP8e6Wu6zyS0jM8jUftlKpm/jgzorjIJ
        PIXfSTqsecmqPBKZ1DOJSMIPcWRs4qwk6X2DBJvDL3spnpDhhQUqadhAgqdbsRHJLa9gllcw
        O8JO9FaFqlxTUSpWZ72fqVFWlqg0ZZkHqio8KPm2Kh+aCRcEEM8hRars9kJNkZxR1mnqKwKI
        cJQiTVb8bW2RXFairD8kqqv2qWvLRU0Avc3RirWy/Ft/75bzpcoasUwUq0X1f1fMpaRrUarL
        uy1/o+PigKPUnZn2+WvqlK3Tytli07uZg4aMPfuzc0+u6R8tVo9aPnmW1f/jBXe04NDGz/4o
        azWvWy680+K7IJ3/qL6R+iqUvusb23Vxb/aL1+cei8dlHU4xduPop+E+U0ZszSPpyObQpOLj
        SO5KxJgDqcVVe20FTe9s2O2uy1fQmoPKrE2UWqP8F3j5iDyyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAyWSa0hTcRjG+5/7JuVhdjmUUEkKWZZa5EuW3agOkSTUh7CollquptVWEmah
        zlabBkua5VxeKpwunTqTzBzl1KzES0qGd/MWS9um3bWbs28vv+fH83x5GVw0TCxmJLHno2Sx
        YqkXJSSEZUykX3vyhYP+A7/XgurJNA0NpYkUOPLTEKTeM1CQ93OKBH1LCgH9k90I7MnTBNha
        nCSkmgZpUGZsg9EuCwYPbCGguF9CQUbZIvjxVUFA7rNg+PY+D0FRm5KCfpORhA9WHQ6/Mp0Y
        qLJKaRjR9FBg761DoHvWS4B5qIOEuiwNBgUPTTg4UiopcF63k9BepafAMFyMz0xdI0CjTadh
        8HUrBk3ZDRSMWm/MsDwFDvpft3C42lOMQWFTMQ1WrQXB9Pc/JLQ9z8Xg7+1yBCU13QSodSMU
        mFXtFFi0AwgSXxWQUD19GJrMhRiUm7U4jLf2EVDR6MDBNvGSgB+lQyT0p1uwrcH8cE02xl+1
        aCi+KLsI8e0db3D+nSmMf1TYifFPdL0075w4wpcX+PL3q20YbzaqKD63ZJjkm7OcBG9vbqb5
        SvMYxltrr6Mwn3DhpsgoqSQuSrY25JgwWpmeQ5w1VmEXlZO1ZCK6q8bUSMBw7Hou6VMjoUZC
        RsSWIe69rZV2BRQbyH1zZBKuez7rw5k/3qNdEs42sVxO5iSpRgzjwW7n9JXzXQ7BenMVqWOz
        eC67havo3PC/fylXpXwziwXsVs6g3+LCohljpE1FapBbLppjRAtjJFJ5zEnJ2YDANXJxbKRE
        fnpNxJkYM5r9I0F4JXp3M8iKMEawOBHtrvXfsy9W/fSObOrgIfXyBUtexN2y93meqLjcRV7x
        axQcDcvP3xlxdIVY575fsezzqvi2UKG8dHfa1KGVX2r+JkSERsDjx5PzUg54XDKMb95RfSzj
        FON2TqqrD/ojqg3123c4zHtvTnlMfcI6VXzHao1sY4fjmnTZcU/M5627x66WJC9CHi0O8MVl
        cvE/OW8UzfcCAAA=
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:63.163.107.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(39860400002)(39450400003)(39850400002)(39410400002)(39840400002)(2980300002)(438002)(189002)(199003)(626004)(7416002)(1076002)(68736007)(5660300001)(50986999)(76176999)(47776003)(2270400002)(189998001)(69596002)(8936002)(111086002)(5890100001)(97736004)(2906002)(50226002)(305945005)(39060400001)(50466002)(356003)(77096006)(48376002)(106466001)(81166006)(81156014)(8666007)(110136003)(54906002)(4326007)(2950100002)(6666003)(36756003)(575784001)(6916009)(5003940100001)(33646002)(8676002)(38730400001)(86362001)(92566002)(7406005)(7366002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1409;H:milsmgep15.sandisk.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD042;1:LtV5eifjF5fGyF+E5p0nTtzScC9jIjNKyVvc+v2kTh2pglN4Tw3cfNtQm34IAll0ioMWMGPgFSdIbVE9D4LIeInD8lhx8EzW6Py7vferY0HJCCwOv1+8MuquUipTWu247CnjmN5PDNJM25zyQLRioDWv3FojSqQJO6xYPPlSVfb81OW+gMYrpwWHfVDKFk/9P2lhJZO1jyjOzgLVTtf8nLUuA4Y/CIAFVI3qiRsC7FX2vhHEmyeiK+X663a4IsEI8eXf+FYPxoS/PKzFNhLQgQjY3M5Xi2yCUEfe+vcJwRUzfOi/2iyTS0i9a76WOEaIFDgbF62KItsuzUlv2OeCqF6TWMOG9gRJHU7c8FW5MbSKNjcj1dBoS0QR35uk9EgZfnmoOqTXSPzi/5n+vWpUF6PyZ1kSFjszgG7uhpPuaMvVX3ikXDYSgnMjjINKMkq6ePsbPHtnymhhDQ2QXYggaPd6SvuDioDi6X7AMYDNA5s9dKwBURGDOZqnmuWN1MN/rMjAn6kGArzOEAS7BntE0qeVCxhzdSpBamA9jN0eWCo=
X-MS-Office365-Filtering-Correlation-Id: c50de4a5-1051-4797-8b8e-08d439bcbc46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002);SRVR:BY2PR02MB1409;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1409;3:M9Pao84SogW1d8qOVFrM4ChYc3u8LKZbDzAB9meHm4lyIQvARSQBHJpcGM6xQZwfRcBO4q5g/EHjpYJDS06d8bSLr4zpaDcqryxl+ZgtkuMDZQuInXrD/e6iqCLCkSnNovu8893E2/3YioBRae2aPDZN1C6S26jom1a9sgrtVkygY38WHcB9U27D4vA1QZhBeHOVNxClejHyT+wNoeBB64qtHSglEyjrp+cbgrptDzhavEyaHIRE0wHOv1s/xeoiCCVYWrGe5Ln9SadluXRhnUwwsQj2wTG4MZKQRGCwlRm3t3kFhJX0r53YQKY67Mh/okbqIkuAeMcfbplq1w1BzI8cDd1VVVzcqRDfcs0wwyQ2rwBUM5hxJbibcf4ZsJ4I8L2wAL2s22uFiB5KTbd8BQ==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1409;25:taiObL8k8XjhzB1vNbMwEO87y63bOi0IBu7GFily5IwzRS/q7/WzyBWqtELQX2ANW/1Gybnc7afFgScLBgS1EBmNkUMMi4j1KCnc1sju8foSgAKqH+rrU9nRWIpjyHVtZlCnBmnv3kX0uF9dmfjDs4kn9xcGhq1Rjt+DArTKvmpOjcXqmaI4EMJbpk891ZafEF27SUY0QkzsQD0FJ3vlHgyncQafZl4mCExuiHbgWZTnAINmN1DZKt64OAesKd49kKNbwcaj6++gdzADefW117tBEG/C4c5YWjBnemIX8Bv43TTdTvcwUf61+lx3JIyoM3Bg8auwAEULCKgkeHOUV+m84DKidAtMPLqHV4X2a0fpYHB+TEGzkdmqWWaMkcFr2E8Y0Gt+0/mYAxX6UaJlUjU4ZhZpc4rEoQITbeg9f56JKeH7QcqroQDNA1e9HLsk8A9ePCMNMNHM6LMAwizp7TYnvd80v9PugTYY/vMnsEu4l72PMNWYrlIdXr+NXotQuHtIynYN1sM9cAlKniuUwZMEX1Adm9TqkKqoUcyhFJljBF2BvUFTq9AwZixonQA6HYW1URoj3Zww6HTAWLMyQA5NAYBtfrhqTouoY/8lr8SpTtIj4b+Pz+KzeFvLCHTCVoBGatiR5etKIukCjR1kDuzg3+L1Xxtjwu8nc1rxk2FDQtyZNUi0O80z4ivn6znHaG3gsU/dNlQZfHkRR9uzhCgDsEvDTTaJjbk2teA+jqkRuldbu3H6fEnSqXVTM3MH4IQZys40D3auSZL9iukJuGVJp0ngweXeh7BPqnJcp0/UuJaPUdhrJwLnFMGYOFzmLRVGEQVtVPD0qs5QroTaQar3Qd4lRPHhxIpJPhdRjQI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1409;31:Qwbg2IIoB9Oj8u5Y+gDruC7qb1RzL9T2pNRWQ85wY4Qg5sO02umcR6l2nVxsc43aw98pfGiOMI3IPIbOdH+XeLsi4Azg+E6ydvN/ZNGtSazka2WJw32s3h3Zxrk/V6GOtYHc5DCPbI0zWqtEu9tZvunKuQctJqVIy3tn2WNk/7/CLJdUb8E7ueeLPElPoVsnqCHXZr9GOQvJfFH0VFlfhS0ZCsvSUIytgnckXPQQjcGcmNv3LdszLzWSLQDBSIM9dK4k4rc+g3GzowEbAJ9lvytYkfrXF8CHuriXoeUZQzY=;20:U6qaUR8lF1A+hLQYptCvqeKhNnbtbE7qKv8uOkBD2daCkqprYVNqq2tsErbKpZFSKAp8j9rvq31QJNCcfyeVzbci54xEfxBS247/f8VxHeXKX411cs51oS8Eml70EFt6tjiwRBJAOc3AJ4e8CHAsFUmZi627jW3kaRXssLJbilN7YoamAS4E9ZDU6bs5PkkwtmoqcTeQH88aN3jepAKjgXhxzhIQEygKa2xZPX3+l/dJcVmqtzJkl5gMf622BvQrEVGSiNHGXVtYEoGgtDs9t8hOBLtvwYo99Ud1csqxKDWwx9Oqeb/GtrnqIdDbxcdnOpCCjruYQt69lMX2XDQPIzVoqKqRBcure7XEvUcs7a9AfjwLZG/QJNbqBoJR64w5EvcY5xAIwCNv09gBiV/h972JjJeBE2LJfyQwyNHNsYhWVB1x+KTqzsq5tpWGW0t6Zcbm0c6E9zpyuhNk1QqmPy63XoCeGrTo1f7bQh48A7QMwScX0TnG7qhk7cM2/gJD
X-Microsoft-Antispam-PRVS: <BY2PR02MB1409B12E35FF00D22CD51CF181660@BY2PR02MB1409.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(253656608321460)(143289334528602)(180628864354917)(31051911155226)(26323138287068)(9452136761055)(65623756079841)(80048183373757)(258649278758335)(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(13016025)(13018025)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:BY2PR02MB1409;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1409;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1409;4:fh5rBRkxFqGxNnwlLbO5MxZKXCgVsSOOfca/xzdubz?=
 =?us-ascii?Q?/cx/Vi0VyS3kxobA013rUVKUSzj44fM6sPOPFrbCCbFHg/SHN/FCHAoxkaRL?=
 =?us-ascii?Q?tBoq3vlMWf2au/ATlUrLnCVg7cNAunZdb/+NhfYLUlS1HF3MdRVvcLMZn6y1?=
 =?us-ascii?Q?QTcBNOebavhsQPdWk/fsT6E0byqarFJGn31pSzPSglqsxP+8pXgIayL0FSuF?=
 =?us-ascii?Q?4/KtScN1RminXGLZ8S08UQm/u9YPlvxJgepVx6ulFpzQvurFpqrgDwvwI6QZ?=
 =?us-ascii?Q?08gScMIvMbpkvwwYUJWq0IB7V3XHnh3sXe9iCwDpuz6YIBD8aptDgkFlp52q?=
 =?us-ascii?Q?3ueDj0ZBTvgU6hpL2Y2ZU3BGg2uxj5NJIhzQX1T/vLG4rrL4P8jMfBaD5/w3?=
 =?us-ascii?Q?1O6bdqH885ER+5L6saP9Ctk6ufHIi+17kRpbJNbHB/LTqaNemA3yIQh4GshA?=
 =?us-ascii?Q?/j6vuIP03XPI8aepNDDwGUDXscOJv2St3t2aL6+CZIha+q54VYxhpzQwqGra?=
 =?us-ascii?Q?JXVzmRKPFGloPUoXuZ415mXxqyaG1oV65R4RZyfMRE/IjEG4fetkCFIQYlTw?=
 =?us-ascii?Q?khqJwDn7ipoPyxhF9Ucf+W1L/wEstZ9C/a/4gDs7kuxVl52xG13iZ9frh2aQ?=
 =?us-ascii?Q?9qgR/4eemnAr0qG+n+klme82jkGSBPD4AFvQGNqF5Y3DcJuhwKmubOzvup2I?=
 =?us-ascii?Q?s1v4C3N0xYIf7Zm4TgD51c121aUX6W7rVecozk5y/qCkmbpoFeyeFpJPtPAj?=
 =?us-ascii?Q?oKHOx0RT1gSAayiVq9t7URuTFUr8U5mibed7P29d0gnh5Eu3xQHJlRaKjXxI?=
 =?us-ascii?Q?+2AXC5xRGC5HcoOMUmQBr6H3VcOTmU8zqJwUntRhdnZmgvV0hHF2LGtn39vZ?=
 =?us-ascii?Q?xvvTr9g5LixAArMNAoI3U59r0vt5cBr+ngygPuNJnaKnXHELw7jvcu+A33Mm?=
 =?us-ascii?Q?7jQjh5wgTYDkw25KAzhXLFtUbGWOzYahC0u3O1DsYTA2nVM/ExqHYXterWyX?=
 =?us-ascii?Q?o=3D?=
X-Forefront-PRVS: 01842C458A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1409;23:lML8tdq5Ws/rckIWL0zOgGpirTYH/vSLb40UZgugu?=
 =?us-ascii?Q?7nC80u3PwEIlD+b5CHqlItTqXIlpFV/HnGY+sQ7AQtlgM+7OYWC4nmflRkB1?=
 =?us-ascii?Q?chYoIwk62VT7htdAVYNJ31OpjjIdAxjdLPN1zmQwBc3n4fbGjAfalhmXm/jt?=
 =?us-ascii?Q?Tg2b3YwG5pkWCFkZAWIdMpR/liCTC+FiOZCdjrNT/GVV5Uh1QYXjuKlGFYSc?=
 =?us-ascii?Q?QxqqIVtaJrg2K3xBwUYr/dRJNaDFASxzNXeRZMjI0PY08T3qVwZK7SheKIXA?=
 =?us-ascii?Q?kcODDnCsuRv+cK66uIH8jBseDgKNCR8Y2SKzeLQ1m0Cv1UHtJhXQ3qNuALTB?=
 =?us-ascii?Q?+/mtulEYzSaAd6mHPRmLUp08AO3vk1A5zOmpBQg5wY3q7Z0bqwgOvhRx6CAm?=
 =?us-ascii?Q?ricdu7Q3xkplcSl4WLIapTXaKtn2qzSrZTdavaF4FbzmC7N1zdRPvhe1Mn7H?=
 =?us-ascii?Q?ikzcto1Vo/dEQ+HyhTmNn9mcRyGf0giQhTCaNvqdhRewCx0Dlooix7Ik5yW8?=
 =?us-ascii?Q?r/ukYFMRLuAc2jMBQnD3b8H7Zm4g6PXUUUUVYBOD4KriLBBmWZam5tBfsRel?=
 =?us-ascii?Q?ekf72j3V6eYPVG9OCIhBivWQyR2vIcUdKrRL2QB/gj3qFH85/LfOYfJzhKWq?=
 =?us-ascii?Q?jMmhieQ+Uhrvqb3twZnpl4nZywSk5sGnYcAMWm6frjoVAfPToSH8iNLpFc6s?=
 =?us-ascii?Q?C+iEMbtNw2WxlBNFkKAcEB0I8gC+ldw0TCxMoeHpD7i0xV74T/F2qYBu+mu6?=
 =?us-ascii?Q?Fd69Mwi8MjsIwpLhC/iqdN8lYIBVI1cbiRYbog+IN1FxhXqp9PFZEgrCvIOw?=
 =?us-ascii?Q?m+Y4tqLSFc9tvWxwIpg6rAW667pQToyQoAtdWuzTtqos89QY1WYFTS+b5DsC?=
 =?us-ascii?Q?WNHcBbjxgXR2uUxHCret7Ko/I5MiKYE8W8jsMDs5Hc6FhVBVHlByXJmw3HFn?=
 =?us-ascii?Q?DK7qTVE/OnZsQCTqYk4ruJNEAsNqKCyMFhy5bmC+LDxhxU6q5ZD+C3EvU2KN?=
 =?us-ascii?Q?5J6JiBcMDSKnAYLBQNTr/ybvIk887gaWRBU/8d/MHBd8+LuYSiSDp2J+wuIx?=
 =?us-ascii?Q?ZZrgifig0JnNnSKCBOwGGH4QdO24GIZX7KQfhqM1LtEl4lES7ohyuhvsPrAh?=
 =?us-ascii?Q?J0PTXAal8JWhs7z1TntT8GeDGQ/VfIGLnn9gBTThCZu0Y+Cr/5TRWt2orw2i?=
 =?us-ascii?Q?mofXnhLQpFNPUAeXvfl63hYRNnpehMJzB+p8NlnH0UvsnxG0vIhpLAmdTFCK?=
 =?us-ascii?Q?kWSzJ6frKTkspwf0WG6zUHcbwsRbl+f9eFKnJ1Guc+gSBnAS9BJuP4CbGv2b?=
 =?us-ascii?Q?U6d/HUqWCNvRXUrENYPnmT4bGEzWmxVsNOaZy82vAvu?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1409;6:AK1KOup5YaSsp3C5UWqLH/MYLExwMa+3xVv5YatCBNNyC5pObq9HuICACHw71o0evfBnuMXvC0vFTiAh8WDELqoIEqaIZMlr3sNJ0+Zcjhj+BVlKFsz73c/o9MCeXRKpt6GDrdDNwVXFEbd/0QXjM9w4fPbALJVLb/6oNgTJ/aHQ8dkUYRtOjTQCouJDmDtHA0rEZRuS/cEiCYQkUd5XdGnA+Wsa5OLMCuAFwZAQzv+CephB2aSqq92bpkYPWzmFjTCHc7xKeXWXrprGTpYt73Rr83aQgTb7Pgr4agYjXZTOUtkdYResmJ33unmIv5r2ruM8p67ZIyW1BbUDgnyLF/Y6o/iISgiI5WjwG8vK51WHS3aoubv1HRofJWCKhSUwKeg49HXMfiAIg4WJhu8R0QcaiaUya9aFOvHs6EXT295RA+ssqshoR5gd2G/vmT46QToIZxCf1Hf0rO7xoEorSA==;5:oW+Kaan3UKCqtvOycroac6Cdt+TE7PFXCEsKCgxBVXJFV8UKNaT4ojljvYlGNWRzCZ0PLfHgd18ODoaWRxGjIXbE3zA6T9kvjNHEViD3UEHiY6t6ocoI0R6p4ea7fCA3rbh1RFyDvchj98mDkykbkQ==;24:jxnV71U5kNEmtfAp7wSqYPiSPwiwhGXdCacx+SWxG9lipWXurdh0t9KuMBihV5+L62SXlGuitLvj6P/1RwC2iYDBMHliqn/PFDO9JrAggmM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1409;7:C2aREj4l6Y9gumyfuH/ZClj6s96Gk7onlzSOY1s6cOxfEqd7eP0qMDG3PgKBB0AqpijHZrTrxzGma40AxBrPvoOtH16FRBKUjcASDz+S5Yj1E3DxZyRYU7tPENkq2wfUzd+Acc9RoVQmZ59/IUymq3VBhh/yth4xQ6ApA1kjJdBgBCOvyKzKB0JF0E6HGgGuXozTeKKwMz+OlpHVu+y/TdjYfyspsllQOwXUWJhmw8xJQHzTV8UnUonWRbQHDGiH+9H5s2tEodCNJOxe0hD5SXLAKgj86OfGeM+a/WGmizi5Lo8QKMttFbjZfJGz48l6VyJVjlOEde+Wv0xoHScGRjjr8QAK7/lQY6uGd9NFlgPw9tqWGZRpOxwCSE8lIaFTuAdMEff0hCuofgF1oiUtiA9ngf4Xg9KMhtAcbdrKXXD843Nokc2mGW1PuEBkW30D6jcLKjwpzzMZ+AETGAjTSw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2017 00:56:53.7089
 (UTC)
X-MS-Exchange-CrossTenant-Id: fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d;Ip=[63.163.107.21];Helo=[milsmgep15.sandisk.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1409
Return-Path: <Bart.VanAssche@sandisk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bart.vanassche@sandisk.com
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

Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
transfer data between memory and PCIe adapter. Because of performance
reasons it is important that the CPU cache is not flushed when such
drivers transfer data. Make this possible by allowing these drivers to
override the dma_map_ops pointer. Additionally, introduce the function
set_dma_ops() that will be used by a later patch in this series.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: David Howells <dhowells@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geoff Levand <geoff@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Helge Deller <deller@gmx.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86@kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-am33-list@redhat.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-cris-kernel@axis.com
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-metag@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: nios2-dev@lists.rocketboards.org
Cc: openrisc@lists.librecores.org
Cc: sparclinux@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
 arch/alpha/include/asm/dma-mapping.h      |  2 +-
 arch/arc/include/asm/dma-mapping.h        |  2 +-
 arch/arm/include/asm/device.h             |  1 -
 arch/arm/include/asm/dma-mapping.h        | 17 ++++-------------
 arch/arm64/include/asm/device.h           |  1 -
 arch/arm64/include/asm/dma-mapping.h      |  8 ++++----
 arch/arm64/mm/dma-mapping.c               |  8 ++++----
 arch/avr32/include/asm/dma-mapping.h      |  2 +-
 arch/blackfin/include/asm/dma-mapping.h   |  2 +-
 arch/c6x/include/asm/dma-mapping.h        |  2 +-
 arch/cris/include/asm/dma-mapping.h       |  4 ++--
 arch/frv/include/asm/dma-mapping.h        |  2 +-
 arch/h8300/include/asm/dma-mapping.h      |  2 +-
 arch/hexagon/include/asm/dma-mapping.h    |  5 +----
 arch/ia64/include/asm/dma-mapping.h       |  5 ++++-
 arch/m32r/include/asm/dma-mapping.h       |  4 +---
 arch/m68k/include/asm/dma-mapping.h       |  2 +-
 arch/metag/include/asm/dma-mapping.h      |  2 +-
 arch/microblaze/include/asm/dma-mapping.h |  2 +-
 arch/mips/include/asm/device.h            |  5 -----
 arch/mips/include/asm/dma-mapping.h       |  7 ++-----
 arch/mips/pci/pci-octeon.c                |  2 +-
 arch/mn10300/include/asm/dma-mapping.h    |  2 +-
 arch/nios2/include/asm/dma-mapping.h      |  2 +-
 arch/openrisc/include/asm/dma-mapping.h   |  2 +-
 arch/parisc/include/asm/dma-mapping.h     |  2 +-
 arch/powerpc/include/asm/device.h         |  4 ----
 arch/powerpc/include/asm/dma-mapping.h    | 17 ++---------------
 arch/powerpc/include/asm/ps3.h            |  2 +-
 arch/powerpc/kernel/dma.c                 |  2 +-
 arch/powerpc/platforms/cell/iommu.c       |  2 +-
 arch/powerpc/platforms/pasemi/iommu.c     |  2 +-
 arch/powerpc/platforms/pasemi/setup.c     |  2 +-
 arch/powerpc/platforms/ps3/system-bus.c   |  4 ++--
 arch/powerpc/platforms/pseries/ibmebus.c  |  2 +-
 arch/s390/include/asm/device.h            |  1 -
 arch/s390/include/asm/dma-mapping.h       |  4 +---
 arch/s390/pci/pci.c                       |  2 +-
 arch/sh/include/asm/dma-mapping.h         |  2 +-
 arch/sparc/include/asm/dma-mapping.h      |  4 ++--
 arch/tile/include/asm/device.h            |  3 ---
 arch/tile/include/asm/dma-mapping.h       | 12 ++----------
 arch/x86/include/asm/device.h             |  3 ---
 arch/x86/include/asm/dma-mapping.h        |  9 +--------
 arch/x86/kernel/pci-calgary_64.c          |  4 ++--
 arch/x86/pci/common.c                     |  2 +-
 arch/x86/pci/sta2x11-fixup.c              |  8 ++++----
 arch/xtensa/include/asm/device.h          |  4 ----
 arch/xtensa/include/asm/dma-mapping.h     |  7 ++-----
 drivers/infiniband/ulp/srpt/ib_srpt.c     |  2 +-
 drivers/iommu/amd_iommu.c                 |  6 +++---
 drivers/misc/mic/bus/mic_bus.c            |  2 +-
 drivers/misc/mic/bus/scif_bus.c           |  2 +-
 drivers/misc/mic/bus/vop_bus.c            |  2 +-
 include/linux/device.h                    |  2 ++
 include/linux/dma-mapping.h               | 12 ++++++++++++
 56 files changed, 85 insertions(+), 140 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index d3480562411d..5d53666935e6 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -3,7 +3,7 @@
 
 extern const struct dma_map_ops *dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return dma_ops;
 }
diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
index fdff3aa60052..94285031c4fb 100644
--- a/arch/arc/include/asm/dma-mapping.h
+++ b/arch/arc/include/asm/dma-mapping.h
@@ -20,7 +20,7 @@
 
 extern const struct dma_map_ops arc_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &arc_dma_ops;
 }
diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index d8a572f9c187..220ba207be91 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -7,7 +7,6 @@
 #define ASMARM_DEVICE_H
 
 struct dev_archdata {
-	const struct dma_map_ops	*dma_ops;
 #ifdef CONFIG_DMABOUNCE
 	struct dmabounce_device_info *dmabounce;
 #endif
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 1aabd781306f..7c6d995fb935 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -18,23 +18,14 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
 
 static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
+	if (dev && dev->dma_ops)
+		return dev->dma_ops;
 	return &arm_dma_ops;
 }
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (xen_initial_domain())
-		return xen_dma_ops;
-	else
-		return __generic_dma_ops(dev);
-}
-
-static inline void set_dma_ops(struct device *dev, const struct dma_map_ops *ops)
-{
-	BUG_ON(!dev);
-	dev->archdata.dma_ops = ops;
+	return xen_initial_domain() ? xen_dma_ops : &arm_dma_ops;
 }
 
 #define HAVE_ARCH_DMA_SUPPORTED 1
diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 00c678cc31e1..73d5bab015eb 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -17,7 +17,6 @@
 #define __ASM_DEVICE_H
 
 struct dev_archdata {
-	const struct dma_map_ops *dma_ops;
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
 #endif
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 1fedb43be712..ff311c67ab0c 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -29,8 +29,8 @@ extern const struct dma_map_ops dummy_dma_ops;
 
 static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
+       if (dev && dev->dma_ops)
+               return dev->dma_ops;
 
 	/*
 	 * We expect no ISA devices, and all other DMA masters are expected to
@@ -39,12 +39,12 @@ static inline const struct dma_map_ops *__generic_dma_ops(struct device *dev)
 	return &dummy_dma_ops;
 }
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	if (xen_initial_domain())
 		return xen_dma_ops;
 	else
-		return __generic_dma_ops(dev);
+		return __generic_dma_ops(NULL);
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index bcef6368d48f..9c80a3cbce59 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -837,7 +837,7 @@ static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
 		return false;
 	}
 
-	dev->archdata.dma_ops = &iommu_dma_ops;
+	set_dma_ops(dev, &iommu_dma_ops);
 	return true;
 }
 
@@ -941,7 +941,7 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 void arch_teardown_dma_ops(struct device *dev)
 {
-	dev->archdata.dma_ops = NULL;
+	set_dma_ops(dev, NULL);
 }
 
 #else
@@ -955,8 +955,8 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-	if (!dev->archdata.dma_ops)
-		dev->archdata.dma_ops = &swiotlb_dma_ops;
+	if (!dev->dma_ops)
+		set_dma_ops(dev, &swiotlb_dma_ops);
 
 	dev->archdata.dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
diff --git a/arch/avr32/include/asm/dma-mapping.h b/arch/avr32/include/asm/dma-mapping.h
index b2b43c0e0774..7388451f9905 100644
--- a/arch/avr32/include/asm/dma-mapping.h
+++ b/arch/avr32/include/asm/dma-mapping.h
@@ -6,7 +6,7 @@ extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 
 extern const struct dma_map_ops avr32_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &avr32_dma_ops;
 }
diff --git a/arch/blackfin/include/asm/dma-mapping.h b/arch/blackfin/include/asm/dma-mapping.h
index 320fb50fbd41..04254ac36bed 100644
--- a/arch/blackfin/include/asm/dma-mapping.h
+++ b/arch/blackfin/include/asm/dma-mapping.h
@@ -38,7 +38,7 @@ _dma_sync(dma_addr_t addr, size_t size, enum dma_data_direction dir)
 
 extern const struct dma_map_ops bfin_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &bfin_dma_ops;
 }
diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/dma-mapping.h
index 88258b9ebc8e..aca9f755e4f8 100644
--- a/arch/c6x/include/asm/dma-mapping.h
+++ b/arch/c6x/include/asm/dma-mapping.h
@@ -19,7 +19,7 @@
 
 extern const struct dma_map_ops c6x_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &c6x_dma_ops;
 }
diff --git a/arch/cris/include/asm/dma-mapping.h b/arch/cris/include/asm/dma-mapping.h
index aae4fbc0a656..256169de3743 100644
--- a/arch/cris/include/asm/dma-mapping.h
+++ b/arch/cris/include/asm/dma-mapping.h
@@ -4,12 +4,12 @@
 #ifdef CONFIG_PCI
 extern const struct dma_map_ops v32_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &v32_dma_ops;
 }
 #else
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	BUG();
 	return NULL;
diff --git a/arch/frv/include/asm/dma-mapping.h b/arch/frv/include/asm/dma-mapping.h
index 150cc00544a8..354900917585 100644
--- a/arch/frv/include/asm/dma-mapping.h
+++ b/arch/frv/include/asm/dma-mapping.h
@@ -9,7 +9,7 @@ extern unsigned long __nongprelbss dma_coherent_mem_end;
 
 extern const struct dma_map_ops frv_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &frv_dma_ops;
 }
diff --git a/arch/h8300/include/asm/dma-mapping.h b/arch/h8300/include/asm/dma-mapping.h
index f804bca4c13f..847c7562e046 100644
--- a/arch/h8300/include/asm/dma-mapping.h
+++ b/arch/h8300/include/asm/dma-mapping.h
@@ -3,7 +3,7 @@
 
 extern const struct dma_map_ops h8300_dma_map_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &h8300_dma_map_ops;
 }
diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index b812e917cd95..d3a87bd9b686 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -34,11 +34,8 @@ extern int bad_dma_address;
 
 extern const struct dma_map_ops *dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (unlikely(dev == NULL))
-		return NULL;
-
 	return dma_ops;
 }
 
diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 05e467d56d86..73ec3c6f4cfe 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -23,7 +23,10 @@ extern void machvec_dma_sync_single(struct device *, dma_addr_t, size_t,
 extern void machvec_dma_sync_sg(struct device *, struct scatterlist *, int,
 				enum dma_data_direction);
 
-#define get_dma_ops(dev) platform_dma_get_ops(dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+{
+	return platform_dma_get_ops(NULL);
+}
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
diff --git a/arch/m32r/include/asm/dma-mapping.h b/arch/m32r/include/asm/dma-mapping.h
index 99c43d2f05dc..c01d9f52d228 100644
--- a/arch/m32r/include/asm/dma-mapping.h
+++ b/arch/m32r/include/asm/dma-mapping.h
@@ -10,10 +10,8 @@
 
 #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
 	return &dma_noop_ops;
 }
 
diff --git a/arch/m68k/include/asm/dma-mapping.h b/arch/m68k/include/asm/dma-mapping.h
index 863509939d5a..9210e470771b 100644
--- a/arch/m68k/include/asm/dma-mapping.h
+++ b/arch/m68k/include/asm/dma-mapping.h
@@ -3,7 +3,7 @@
 
 extern const struct dma_map_ops m68k_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
         return &m68k_dma_ops;
 }
diff --git a/arch/metag/include/asm/dma-mapping.h b/arch/metag/include/asm/dma-mapping.h
index c156a7ac732f..fad3dc3cb210 100644
--- a/arch/metag/include/asm/dma-mapping.h
+++ b/arch/metag/include/asm/dma-mapping.h
@@ -3,7 +3,7 @@
 
 extern const struct dma_map_ops metag_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &metag_dma_ops;
 }
diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index c7faf2fb51d6..3fad5e722a66 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -38,7 +38,7 @@
  */
 extern const struct dma_map_ops dma_direct_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &dma_direct_ops;
 }
diff --git a/arch/mips/include/asm/device.h b/arch/mips/include/asm/device.h
index ebc5c1265473..6aa796f1081a 100644
--- a/arch/mips/include/asm/device.h
+++ b/arch/mips/include/asm/device.h
@@ -6,12 +6,7 @@
 #ifndef _ASM_MIPS_DEVICE_H
 #define _ASM_MIPS_DEVICE_H
 
-struct dma_map_ops;
-
 struct dev_archdata {
-	/* DMA operations on that device */
-	const struct dma_map_ops *dma_ops;
-
 #ifdef CONFIG_DMA_PERDEV_COHERENT
 	/* Non-zero if DMA is coherent with CPU caches */
 	bool dma_coherent;
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index b59b084a7569..aba71385f9d1 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -11,12 +11,9 @@
 
 extern const struct dma_map_ops *mips_dma_map_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
-	else
-		return mips_dma_map_ops;
+	return mips_dma_map_ops;
 }
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 308d051fc45c..7da99a908229 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -167,7 +167,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
 	}
 
-	dev->dev.archdata.dma_ops = octeon_pci_dma_map_ops;
+	set_dma_ops(&dev->dev, octeon_pci_dma_map_ops);
 
 	return 0;
 }
diff --git a/arch/mn10300/include/asm/dma-mapping.h b/arch/mn10300/include/asm/dma-mapping.h
index 564e3927e005..737ef574b3ea 100644
--- a/arch/mn10300/include/asm/dma-mapping.h
+++ b/arch/mn10300/include/asm/dma-mapping.h
@@ -16,7 +16,7 @@
 
 extern const struct dma_map_ops mn10300_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &mn10300_dma_ops;
 }
diff --git a/arch/nios2/include/asm/dma-mapping.h b/arch/nios2/include/asm/dma-mapping.h
index aa00d839a64b..7b3c6f280293 100644
--- a/arch/nios2/include/asm/dma-mapping.h
+++ b/arch/nios2/include/asm/dma-mapping.h
@@ -12,7 +12,7 @@
 
 extern const struct dma_map_ops nios2_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &nios2_dma_ops;
 }
diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index 88acbedb4947..0c0075f17145 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -30,7 +30,7 @@
 
 extern const struct dma_map_ops or1k_dma_map_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return &or1k_dma_map_ops;
 }
diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/include/asm/dma-mapping.h
index 1749073e44fc..5404c6a726b2 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -27,7 +27,7 @@ extern const struct dma_map_ops pcx_dma_ops;
 
 extern const struct dma_map_ops *hppa_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return hppa_dma_ops;
 }
diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 49cbb0fca233..0245bfcaac32 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -6,7 +6,6 @@
 #ifndef _ASM_POWERPC_DEVICE_H
 #define _ASM_POWERPC_DEVICE_H
 
-struct dma_map_ops;
 struct device_node;
 #ifdef CONFIG_PPC64
 struct pci_dn;
@@ -20,9 +19,6 @@ struct iommu_table;
  * drivers/macintosh/macio_asic.c
  */
 struct dev_archdata {
-	/* DMA operations on that device */
-	const struct dma_map_ops	*dma_ops;
-
 	/*
 	 * These two used to be a union. However, with the hybrid ops we need
 	 * both so here we store both a DMA offset for direct mappings and
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 2ec3eadf336f..efdcf87c4c2f 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -78,22 +78,9 @@ extern struct dma_map_ops dma_iommu_ops;
 #endif
 extern const struct dma_map_ops dma_direct_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/* We don't handle the NULL dev case for ISA for now. We could
-	 * do it via an out of line call but it is not needed for now. The
-	 * only ISA DMA device we support is the floppy and we have a hack
-	 * in the floppy driver directly to get a device for us.
-	 */
-	if (unlikely(dev == NULL))
-		return NULL;
-
-	return dev->archdata.dma_ops;
-}
-
-static inline void set_dma_ops(struct device *dev, const struct dma_map_ops *ops)
-{
-	dev->archdata.dma_ops = ops;
+	return NULL;
 }
 
 /*
diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index a19f831a4cc9..17ee719e799f 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -435,7 +435,7 @@ static inline void *ps3_system_bus_get_drvdata(
 	return dev_get_drvdata(&dev->core);
 }
 
-/* These two need global scope for get_dma_ops(). */
+/* These two need global scope for get_arch_dma_ops(). */
 
 extern struct bus_type ps3_system_bus_type;
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 03b98f1f98ec..41c749586bd2 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -33,7 +33,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	struct dev_archdata __maybe_unused *sd = &dev->archdata;
 
 #ifdef CONFIG_SWIOTLB
-	if (sd->max_direct_dma_addr && sd->dma_ops == &swiotlb_dma_ops)
+	if (sd->max_direct_dma_addr && dev->dma_ops == &swiotlb_dma_ops)
 		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
 #endif
 
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index e1413e69e5fe..592a2a0f4860 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -692,7 +692,7 @@ static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
 		return 0;
 
 	/* We use the PCI DMA ops */
-	dev->archdata.dma_ops = get_pci_dma_ops();
+	set_dma_ops(dev, get_pci_dma_ops());
 
 	cell_dma_dev_setup(dev);
 
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index e74adc4e7fd8..66bf56788260 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -186,7 +186,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	 */
 	if (dev->vendor == 0x1959 && dev->device == 0xa007 &&
 	    !firmware_has_feature(FW_FEATURE_LPAR)) {
-		dev->dev.archdata.dma_ops = &dma_direct_ops;
+		set_dma_ops(&dev->dev, &dma_direct_ops);
 		/*
 		 * Set the coherent DMA mask to prevent the iommu
 		 * being used unnecessarily
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 3182400cf48f..a00412d369f8 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -363,7 +363,7 @@ static int pcmcia_notify(struct notifier_block *nb, unsigned long action,
 		return 0;
 
 	/* We use the direct ops for localbus */
-	dev->archdata.dma_ops = &dma_direct_ops;
+	set_dma_ops(dev, &dma_direct_ops);
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index c81450d98794..b78041049146 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -756,11 +756,11 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 
 	switch (dev->dev_type) {
 	case PS3_DEVICE_TYPE_IOC0:
-		dev->core.archdata.dma_ops = &ps3_ioc0_dma_ops;
+		set_dma_ops(&dev->core, &ps3_ioc0_dma_ops);
 		dev_set_name(&dev->core, "ioc0_%02x", ++dev_ioc0_count);
 		break;
 	case PS3_DEVICE_TYPE_SB:
-		dev->core.archdata.dma_ops = &ps3_sb_dma_ops;
+		set_dma_ops(&dev->core, &ps3_sb_dma_ops);
 		dev_set_name(&dev->core, "sb_%02x", ++dev_sb_count);
 
 		break;
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index 2e36a0b8944a..05063fd9b05f 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -169,7 +169,7 @@ static int ibmebus_create_device(struct device_node *dn)
 		return -ENOMEM;
 
 	dev->dev.bus = &ibmebus_bus_type;
-	dev->dev.archdata.dma_ops = &ibmebus_dma_ops;
+	set_dma_ops(&dev->dev, &ibmebus_dma_ops);
 
 	ret = of_device_add(dev);
 	if (ret)
diff --git a/arch/s390/include/asm/device.h b/arch/s390/include/asm/device.h
index 7955a9799466..5203fc87f080 100644
--- a/arch/s390/include/asm/device.h
+++ b/arch/s390/include/asm/device.h
@@ -4,7 +4,6 @@
  * This file is released under the GPLv2
  */
 struct dev_archdata {
-	const struct dma_map_ops *dma_ops;
 };
 
 struct pdev_archdata {
diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index 2776d205b1ff..3108b8dbe266 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -12,10 +12,8 @@
 
 extern const struct dma_map_ops s390_pci_dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
 	return &dma_noop_ops;
 }
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 38e17d4d9884..5b4177d8f4c3 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -641,7 +641,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 	int i;
 
 	pdev->dev.groups = zpci_attr_groups;
-	pdev->dev.archdata.dma_ops = &s390_pci_dma_ops;
+	set_dma_ops(&pdev->dev, &s390_pci_dma_ops);
 	zpci_map_resources(pdev);
 
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index a7382c34c241..d99008af5f73 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -4,7 +4,7 @@
 extern const struct dma_map_ops *dma_ops;
 extern void no_iommu_init(void);
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	return dma_ops;
 }
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 3d2babc0c4c6..69cc627779f2 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -24,14 +24,14 @@ extern const struct dma_map_ops pci32_dma_ops;
 
 extern struct bus_type pci_bus_type;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_SPARC_LEON
 	if (sparc_cpu_model == sparc_leon)
 		return leon_dma_ops;
 #endif
 #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
-	if (dev->bus == &pci_bus_type)
+	if (bus == &pci_bus_type)
 		return &pci32_dma_ops;
 #endif
 	return dma_ops;
diff --git a/arch/tile/include/asm/device.h b/arch/tile/include/asm/device.h
index 25f23ac7d361..1cf45422a0df 100644
--- a/arch/tile/include/asm/device.h
+++ b/arch/tile/include/asm/device.h
@@ -17,9 +17,6 @@
 #define _ASM_TILE_DEVICE_H
 
 struct dev_archdata {
-	/* DMA operations on that device */
-        const struct dma_map_ops	*dma_ops;
-
 	/* Offset of the DMA address from the PA. */
 	dma_addr_t		dma_offset;
 
diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 4a06cc75b856..bbc71a29b2c6 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -29,12 +29,9 @@ extern const struct dma_map_ops *gx_pci_dma_map_ops;
 extern const struct dma_map_ops *gx_legacy_pci_dma_map_ops;
 extern const struct dma_map_ops *gx_hybrid_pci_dma_map_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
-	else
-		return tile_dma_map_ops;
+	return tile_dma_map_ops;
 }
 
 static inline dma_addr_t get_dma_offset(struct device *dev)
@@ -59,11 +56,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
-static inline void set_dma_ops(struct device *dev, const struct dma_map_ops *ops)
-{
-	dev->archdata.dma_ops = ops;
-}
-
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	if (!dev->dma_mask)
diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index b2d0b4ced7e3..1b3ef26e77df 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -2,9 +2,6 @@
 #define _ASM_X86_DEVICE_H
 
 struct dev_archdata {
-#ifdef CONFIG_X86_DEV_DMA_OPS
-	const struct dma_map_ops *dma_ops;
-#endif
 #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
 	void *iommu; /* hook for IOMMU specific extension */
 #endif
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 5e4772886a1e..08a0838b83fb 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -27,16 +27,9 @@ extern int panic_on_overflow;
 
 extern const struct dma_map_ops *dma_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-#ifndef CONFIG_X86_DEV_DMA_OPS
 	return dma_ops;
-#else
-	if (unlikely(!dev) || !dev->archdata.dma_ops)
-		return dma_ops;
-	else
-		return dev->archdata.dma_ops;
-#endif
 }
 
 bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 17f180148c80..87f9a1ff7cf6 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -1177,7 +1177,7 @@ static int __init calgary_init(void)
 		tbl = find_iommu_table(&dev->dev);
 
 		if (translation_enabled(tbl))
-			dev->dev.archdata.dma_ops = &calgary_dma_ops;
+			set_dma_ops(&dev->dev, &calgary_dma_ops);
 	}
 
 	return ret;
@@ -1201,7 +1201,7 @@ static int __init calgary_init(void)
 		calgary_disable_translation(dev);
 		calgary_free_bus(dev);
 		pci_dev_put(dev); /* Undo calgary_init_one()'s pci_dev_get() */
-		dev->dev.archdata.dma_ops = NULL;
+		set_dma_ops(&dev->dev, NULL);
 	} while (1);
 
 	return ret;
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index a4fdfa7dcc1b..944e13c1a1e4 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -667,7 +667,7 @@ static void set_dma_domain_ops(struct pci_dev *pdev)
 	spin_lock(&dma_domain_list_lock);
 	list_for_each_entry(domain, &dma_domain_list, node) {
 		if (pci_domain_nr(pdev->bus) == domain->domain_nr) {
-			pdev->dev.archdata.dma_ops = domain->dma_ops;
+			set_dma_ops(&pdev->dev, domain->dma_ops);
 			break;
 		}
 	}
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index aa3828823170..21008548f225 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -203,7 +203,7 @@ static void sta2x11_setup_pdev(struct pci_dev *pdev)
 		return;
 	pci_set_consistent_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
 	pci_set_dma_mask(pdev, STA2X11_AMBA_SIZE - 1);
-	pdev->dev.archdata.dma_ops = &sta2x11_dma_ops;
+	set_dma_ops(&pdev->dev, &sta2x11_dma_ops);
 
 	/* We must enable all devices as master, for audio DMA to work */
 	pci_set_master(pdev);
@@ -223,7 +223,7 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 	struct sta2x11_mapping *map;
 
-	if (dev->archdata.dma_ops != &sta2x11_dma_ops) {
+	if (dev->dma_ops != &sta2x11_dma_ops) {
 		if (!dev->dma_mask)
 			return false;
 		return addr + size - 1 <= *dev->dma_mask;
@@ -247,7 +247,7 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
  */
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	if (dev->archdata.dma_ops != &sta2x11_dma_ops)
+	if (dev->dma_ops != &sta2x11_dma_ops)
 		return paddr;
 	return p2a(paddr, to_pci_dev(dev));
 }
@@ -259,7 +259,7 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
  */
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	if (dev->archdata.dma_ops != &sta2x11_dma_ops)
+	if (dev->dma_ops != &sta2x11_dma_ops)
 		return daddr;
 	return a2p(daddr, to_pci_dev(dev));
 }
diff --git a/arch/xtensa/include/asm/device.h b/arch/xtensa/include/asm/device.h
index a77d45d39f35..1deeb8ebbb1b 100644
--- a/arch/xtensa/include/asm/device.h
+++ b/arch/xtensa/include/asm/device.h
@@ -6,11 +6,7 @@
 #ifndef _ASM_XTENSA_DEVICE_H
 #define _ASM_XTENSA_DEVICE_H
 
-struct dma_map_ops;
-
 struct dev_archdata {
-	/* DMA operations on that device */
-	const struct dma_map_ops *dma_ops;
 };
 
 struct pdev_archdata {
diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 50d23106cce0..c6140fa8c0be 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -20,12 +20,9 @@
 
 extern const struct dma_map_ops xtensa_dma_map_ops;
 
-static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (dev && dev->archdata.dma_ops)
-		return dev->archdata.dma_ops;
-	else
-		return &xtensa_dma_map_ops;
+	return &xtensa_dma_map_ops;
 }
 
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 3fc3f8b5752b..20444a7d867d 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2524,7 +2524,7 @@ static void srpt_add_one(struct ib_device *device)
 	int i;
 
 	pr_debug("device = %p, device->dma_ops = %p\n", device,
-		 device->dma_ops);
+		 get_dma_ops(device->dma_device));
 
 	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
 	if (!sdev)
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3703fb9db419..246a88d96a97 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -515,7 +515,7 @@ static void iommu_uninit_device(struct device *dev)
 	iommu_group_remove_device(dev);
 
 	/* Remove dma-ops */
-	dev->archdata.dma_ops = NULL;
+	set_dma_ops(dev, NULL);
 
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
@@ -2164,7 +2164,7 @@ static int amd_iommu_add_device(struct device *dev)
 				dev_name(dev));
 
 		iommu_ignore_device(dev);
-		dev->archdata.dma_ops = &nommu_dma_ops;
+		set_dma_ops(dev, &nommu_dma_ops);
 		goto out;
 	}
 	init_iommu_group(dev);
@@ -2181,7 +2181,7 @@ static int amd_iommu_add_device(struct device *dev)
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		dev_data->passthrough = true;
 	else
-		dev->archdata.dma_ops = &amd_iommu_dma_ops;
+		set_dma_ops(dev, &amd_iommu_dma_ops);
 
 out:
 	iommu_completion_wait(iommu);
diff --git a/drivers/misc/mic/bus/mic_bus.c b/drivers/misc/mic/bus/mic_bus.c
index c4b27a25662a..ee6e4ef370ea 100644
--- a/drivers/misc/mic/bus/mic_bus.c
+++ b/drivers/misc/mic/bus/mic_bus.c
@@ -158,7 +158,7 @@ mbus_register_device(struct device *pdev, int id, const struct dma_map_ops *dma_
 	mbdev->dev.parent = pdev;
 	mbdev->id.device = id;
 	mbdev->id.vendor = MBUS_DEV_ANY_ID;
-	mbdev->dev.archdata.dma_ops = dma_ops;
+	set_dma_ops(&mbdev->dev, dma_ops);
 	mbdev->dev.dma_mask = &mbdev->dev.coherent_dma_mask;
 	dma_set_mask(&mbdev->dev, DMA_BIT_MASK(64));
 	mbdev->dev.release = mbus_release_dev;
diff --git a/drivers/misc/mic/bus/scif_bus.c b/drivers/misc/mic/bus/scif_bus.c
index e5d377e97c86..d4d559cad6a1 100644
--- a/drivers/misc/mic/bus/scif_bus.c
+++ b/drivers/misc/mic/bus/scif_bus.c
@@ -154,7 +154,7 @@ scif_register_device(struct device *pdev, int id, const struct dma_map_ops *dma_
 	sdev->dev.parent = pdev;
 	sdev->id.device = id;
 	sdev->id.vendor = SCIF_DEV_ANY_ID;
-	sdev->dev.archdata.dma_ops = dma_ops;
+	set_dma_ops(&sdev->dev, dma_ops);
 	sdev->dev.release = scif_release_dev;
 	sdev->hw_ops = hw_ops;
 	sdev->dnode = dnode;
diff --git a/drivers/misc/mic/bus/vop_bus.c b/drivers/misc/mic/bus/vop_bus.c
index b59551f5db65..c96a05f811f2 100644
--- a/drivers/misc/mic/bus/vop_bus.c
+++ b/drivers/misc/mic/bus/vop_bus.c
@@ -154,7 +154,7 @@ vop_register_device(struct device *pdev, int id,
 	vdev->dev.parent = pdev;
 	vdev->id.device = id;
 	vdev->id.vendor = VOP_DEV_ANY_ID;
-	vdev->dev.archdata.dma_ops = (const struct dma_map_ops *)dma_ops;
+	set_dma_ops(&vdev->dev, dma_ops);
 	vdev->dev.dma_mask = &vdev->dev.coherent_dma_mask;
 	dma_set_mask(&vdev->dev, DMA_BIT_MASK(64));
 	vdev->dev.release = vop_release_dev;
diff --git a/include/linux/device.h b/include/linux/device.h
index 491b4c0ca633..c7cb225d36b0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -885,6 +885,8 @@ struct dev_links_info {
  * a higher-level representation of the device.
  */
 struct device {
+	const struct dma_map_ops *dma_ops; /* See also get_dma_ops() */
+
 	struct device		*parent;
 
 	struct device_private	*p;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f1da68b82c63..ab8710888ddf 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -164,6 +164,18 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
+static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
+{
+	if (dev && dev->dma_ops)
+		return dev->dma_ops;
+	return get_arch_dma_ops(dev ? dev->bus : NULL);
+}
+
+static inline void set_dma_ops(struct device *dev,
+			       const struct dma_map_ops *dma_ops)
+{
+	dev->dma_ops = dma_ops;
+}
 #else
 /*
  * Define the dma api to allow compilation but not linking of
-- 
2.11.0
