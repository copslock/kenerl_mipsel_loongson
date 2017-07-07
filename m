Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:45:38 +0200 (CEST)
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:61888
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993941AbdGGOpb4n6yb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jul 2017 16:45:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wzLXsRhWYz/s1XczddnMZ3iypTbnC2Bd8bxAyPiFDKo=;
 b=X/dzjoBYyIYopoLo+/43mHb+vfEUMMlxZsksynIMYRnBnuR7mUIDHvpwGf2bWfKcG7rDDEDIfzoaWUkD3t6DfaS3Sg2hCzM8PpBFfGFrDtUTqbC5Y4yBRIEQv0xzb3asDlVgSo6U91Fkt+ial818viCv93SgxS/K8wRjony0UUg=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from [10.0.0.4] (173.18.42.219) by
 BY1PR0701MB1222.namprd07.prod.outlook.com (10.160.105.153) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1220.11; Fri, 7
 Jul 2017 14:45:24 +0000
Subject: Re: [mips-sjhill:mips-for-linux-next 36/72]
 arch/mips/include/asm/cmpxchg.h:135:8: error: expected ':' or ')' before
 '__scbeqz'
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org
References: <201706300326.dDkxWeg8%fengguang.wu@intel.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <ab6bbbbf-6307-df8c-8440-1463e7821c5a@cavium.com>
Date:   Fri, 7 Jul 2017 09:45:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <201706300326.dDkxWeg8%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: MWHPR22CA0005.namprd22.prod.outlook.com (10.172.163.143) To
 BY1PR0701MB1222.namprd07.prod.outlook.com (10.160.105.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8059b719-2f0f-4a37-c904-08d4c546cd26
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(300000503095)(300135400095)(201703131423075)(201703031133081)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BY1PR0701MB1222;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1222;3:A2zRmLkSW6Bn3W8nv5HMsETdHnukdLUGza39nQzxitFOUtRMYai1H3m/iqSOxxxsDyt1Q/r4aHLoaccoQPjU0NhG1qLXEssmgiA0jOWBgy64fQuJytncImdXTSY8lwyagb7KEjVPv9dVHobfYv2pZ0QUgIUiJKMT+7GebSO0bDmWjgXayf1MB7QXdezhZoILrg+TEeLAk9yqS3JLnm6qakTFATVQPyhbShqh3OWl/LrO2Dc0IfjpTm6ymK3WqLyW/1C3zoKpTdtjpgH5rH1MDQCOMXd0ROS1Ft0ExIHAehzCJ9CDAbMqafFocfU2kd/2cCn1LtXpRbn1S55EUihfuqVqnUWzTpUQx12nTW3ikl5MArSaasTfOcsyB1/+djByK/lJYdus7XpkOBroiklGP3LgTmj15VoCdDcsmC1xMba/ct7wIcPRyknp89DqhPwUQWCUkqpqPjn/wWeoO+9loVUstBWE/wmgZGwE61hroG9evBVC/MWS2a+iupNnBZ290WgHYCPgZNO9R8/bSVq4UvD9zqu9d4yt3zx6N8+SorU0Qy8cKdKugQNYawAw7npT4/4wT4/1+HivNGEGKvoHQwtKj9O9mvE5x/2A7NGcZM0bi/kydVGorV9tEfA26NNTLMBsUGGQk5ufva0uqQRaRwxPuxNVwwh5+WhR/D9OuioJ6LGNZsbjrSNORtvdT3uDFUNXfA1x/XOEpI+KCLgcX32EOGNxXbujXOE1A/cY26tTbCkY0JGkLV6N7IjPXipt
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1222:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1222;25:y0PdWrOfQwQ8n8W5G3zdkZRxW3UgFEK7IcBTkI75GEEr83dwieTCD43+sc/e8o3sK/jPjsJ84+aGlYU+RAG3JsyuUjsHZHBzNpmYYl4NbZJp77+p+W+4QSEDb3cwDk80yieOWK2Cv1DtNVUGodbrPCAGlyn/G99t+TiaTIMITpeuP59X8qBUyb2s/gSLt/Tj/16dC7EyTmpzGGYsV2ErvO4mWxi+VcKnv4apSaa0qRqKX3dQdRd21fU8u7Db2gFbJbzCc4sewvOMMyIdBkKKJrj6L0DJQ3z/WQlbrJljVuV0M5VXVV0JsK4kTVGDzT/S0oE+r74E0+Gtq+qyygZ9aqVzk2ABhiif/ENs7fRU20EYCgJlXCdJo1j+m2pOvFG2mUodJvDlCW1RCuoC1m+v4T3z8f/V4zVhyMLSJGz+i7BCw5zPI8LnATXSJQ//EfZYrGvfFRx9P3ItBkV8qBHSYFhQpkqMlfIXB+ne6qqQcn6qgXajbBDsVaRtU73HS2ysriGFLloW7vsKn4lO387z9givvDIHRAxPg92bXxhU31u1iMGA03W76c313v8lvQZjtVjujWPgykuOrF/BsjztKtrl6szo8+T6fOuZYtI/vFeJjYOTzbXui4K/zkMAgDVugpa6TVShBod+DW4aGkSkFx8uOu9QLSv4WvLmuA1Q9HHr1m8wagShzr9nXJCm+sGbyGKUCOzjlsZmK/keFXp0vE8MvKuM5crkWqQrw+83Tx6cBaLVytXbfrYWR2hIzS1eaGKTYzzyxLwUr/nJBTg9Xg5ieE4CllJp47q6Z/AY1/OakV8OOHLle3GYS35FPorVOl+onyCPgKq7eLFJACdwxUf0THmjud+nOaD9TuwfCsIZXQ4puDuA7Tz2nljJq5+MYzAPy24i59x1DqGQMlaouN6QQ/r96c2dLUl8Yq10V2A=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1222;31:ZRBro4QMCwj4kvxyqt7cyfGrL11M6KJ+p8GUpzzsnfYkzIn4TETL8DekwExwkNIaU1+HgTOSAFoRTV8H8dYD7e0aJRHjtIYyTYcZlkRSkE1RXr8cq1Wc9ZWjoszeKftxQn9S5Bb6HEep5KLEb4sbDMieKcIdqJuIdtPajt7R297HUSp7rfF1CpBY90kWRBeP3+ZGPkt2uQa5MhsHAjZnM2H4XMH82Jy8Pfw62xHz7lOMeQ/2H27Do79p4N4zzXMnsCsYo7gwigPJNCShLkfnQxHCRd/LQ5+nf6SwZQ3Ca2D+E/NojL8jl9O3K44DUuJXsLoOCvmHCRSwVevk0yU78pOurJWXTpaKOAapsbQiaTB/9bv336iIwiZZLRX/GGafIq/LyIliHf0MZncZ9Hh2jr5jLfs9moUT4BJV2dtWPkojJbcB7tyMkGK68cZUO+KJbrfqg4JYum5tYouHybGObJmp2eEjoDZhphMamcGvfw45vf9mlBmQ9iXmfBpP2/xsoQuub8eQPtp6gzSQIPP7aWoVcUUWTD3ppVLnGYaMJEAnTRRjK9NOKQlmPC5GaGnWglmCL6zwjH3f2UFfcwuYILXIsmC8Jojwltq3AW7l6J2EwdDc6qGqxAalkgb5Hwrk5Gt5SoJRu/Gcmp5PpHF/wohLMilnbblidRxk60NbVSMa/irV8qaZBJnsw/CxPrPG
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1222;20:N6M8CMgeJuyzW9u5JpiZWqRIaGAbXrynUwtYci9qHZZoqtdH7Yxciq6rXL/rQA7TKCy3XMcy1Sn7baGAZXXE8BNN57suDEMT/MbkYs0VOqbVgnTK5JWGlHkVhGnpYSpRPkoCqqW2zJZIxgz4ZFUAqEeRXb6zRb1/ER+4uB/tmHxnBDi5PJtuP1Yz8+XRGa3/qlNPXePU7Kzyvu8beUi0JjVgh1fPTmXH7a5MnZa74cqj4MoaEQ5Rsb6HomOzf+CNNLciAz27Xeif+LamtoplKxInJUPjPqa2URXl5eeVWG370eiUuDOcnchDkzI9mE2hndHIqTeOxaKyACJM+9wYcU/Vfwo8cKHCrkzE0rqlJcRl29TwwpuA6t/i1mRMFSKGGPbY4DsPLFC5SGDyOHOgIQVo74n6wKmoB+QnK7yGWatQ+V4dh7bKT7e3+4//nc/z8ZyfizBo5HA3SqzDrVHvodhyvNY64Ci4DE4sWorE9Mg9na7jcipPfyiu2yTKDhhT
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1222C3B99A415D8BADAE843B80AA0@BY1PR0701MB1222.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(236129657087228)(275740015457677);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BY1PR0701MB1222;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BY1PR0701MB1222;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY1PR0701MB1222;4:tImxGreQTNbkTv+LeQGqG0FdUltSuWllKDRD?=
 =?Windows-1252?Q?6auNLSfph9J2uFd7TCgRM5wsUWusKuAbRUxxbMOUFiXjx/B0GX3dOn6E?=
 =?Windows-1252?Q?l/oZdreSnlvpmpttjolMeSXAOVBzmfnBYbKUvaJpXoPYwcyJIpaK1Tvn?=
 =?Windows-1252?Q?a2Ab712vcV+PbO0Aw+WtpDfOaEyOwbfLPpaZzDfYVLfyaZCBuhB8eMlR?=
 =?Windows-1252?Q?vl73aJRvcgupf/ODvXtPMYMkpXxJOewl9kMTEbPfLoFNuskQ7+Q/SF9G?=
 =?Windows-1252?Q?SRJUQy8F/xWVdUwbyT44386T7eCSYWPq830wF7AlZG9QpTdB6dfnbXXt?=
 =?Windows-1252?Q?CwwfeDIILcMi9rgciwFHXc+Rujqqx5JPQhakyHovAVl8RNaHsfmrmGgG?=
 =?Windows-1252?Q?ZRYUI/hg3Nv6WzFcPX/r1kCQHNahi4uyOG8MupN5jvyB6VHSyVW/qApK?=
 =?Windows-1252?Q?e8957b6bBDscMqND9YXQp01/vM3f+GYswhMA/vODfWbs+z6iEAT5KXYL?=
 =?Windows-1252?Q?LTZ8HWohLgdO8hK1uqyntOA4xTHft3iwVyM29Xm4jBhzxZ4S+3U0XyCz?=
 =?Windows-1252?Q?gBVZkYkbrW3ZxADg4Z0gzk6aT2Qe+rAEoLcKITa+9qYGeSjc75sopL3z?=
 =?Windows-1252?Q?UL6hfNX2fP2m9ZlX55XMwmicCGESUnLCL0cL/Vigj9SViEkNji8ArEJe?=
 =?Windows-1252?Q?UbGs3loW1gO8TSjeXw83XTnRtOZMxoY7meXrMaygcXFFw6tpa/PImUb6?=
 =?Windows-1252?Q?9mdkhzvZtLkICRJDxk2ZIObyAZT0/RLnFJwaoqLvZ9Jotl23jMj1Fai6?=
 =?Windows-1252?Q?CaEBy++hVqoNQh0Jy/YJEDnz8pjA5/DL6iCfmGT/R4BNlT3WeGm79OYB?=
 =?Windows-1252?Q?9t3X8PcWh3oYR4BtwNbMxuHRP/r6D5L/IKTvcg8c2jjKZQ9wbxqZf7+R?=
 =?Windows-1252?Q?0sOXmQtKxh4X3WNELiTDDJRz896f1kNuIjY1t/0KD+9ASp/pJbXCjLaP?=
 =?Windows-1252?Q?V5TVPHwW8zHUv0X6cqSYnf9brB/UwwnPpMAUyFGVBDokt2DcokGil7LO?=
 =?Windows-1252?Q?QvYuDso18/tztverxGcYn2U37b2/q0//jK2F9dqYNk1ZoFlpjpo3U4jx?=
 =?Windows-1252?Q?/3Bm9D4RipR72L5dRw8Q9squ0d8mu0tQqT+0XaTioVef5x+19dQfUvGv?=
 =?Windows-1252?Q?UBzFeR8etS29DNsbMYHV4ooUJ4aykls0GBIGDjziqKOuECSpVIQFTMSO?=
 =?Windows-1252?Q?9kvS6uOdqsEtquGkHz7P5jJR46y1ru+oQz0258g5nj7SYA2L3+w09T9g?=
 =?Windows-1252?Q?4i5qo92em15pilaw5bVFMoGAKQ=3D=3D?=
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(39840400002)(39850400002)(39400400002)(39450400003)(39410400002)(24454002)(377454003)(3846002)(54356999)(86362001)(5660300001)(6916009)(575784001)(478600001)(31686004)(31696002)(42186005)(2950100002)(6666003)(8676002)(81166006)(7736002)(189998001)(2906002)(33646002)(38730400002)(4326008)(305945005)(230783001)(47776003)(66066001)(50986999)(6116002)(6246003)(110136004)(229853002)(64126003)(53936002)(6306002)(6486002)(36756003)(83506001)(76176999)(966005)(23746002)(50466002)(90366009)(5890100001)(72206003)(53546010)(25786009)(77096006)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1222;H:[10.0.0.4];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY1PR0701MB1222;23:6uip/5B0FBVTQBMhNIzVj13dftCN65BZXAy?=
 =?Windows-1252?Q?OwclnQkTLX56Bueq93+98OVSRh2/rT6GCiq5AVOibkYUIZmX3BULjMHx?=
 =?Windows-1252?Q?JdeADxFz9Gkf9PD26m4WZgIR6EYq+QT5VTC8BP18rekBG+NWk1bwAAvb?=
 =?Windows-1252?Q?cN89SzbeEYdW7edK22g6mzSc57UfdQeKWMwjmElR4K9zpmfUKZvp9BkW?=
 =?Windows-1252?Q?twoutI0+qdCeC9wFcUp8jpdyPQkaE+Fbu4wqLJi7K2z+oo2AUu84peyn?=
 =?Windows-1252?Q?eBJsUex4yivEhY3uhcJSDY43QEZm27NdNdExihWyMj8IfnAD693D3Q31?=
 =?Windows-1252?Q?WWc6TjLRofQ6rKG8RxCZAtzSAFfLk+p1lG51UunEKcwZ+tbxPfLbccD7?=
 =?Windows-1252?Q?ZpThd6FgBLznZwZ8YvF5oPVByG2c31XgFd6zFsW9RkWyvlUfHYI7ro1u?=
 =?Windows-1252?Q?5p+G87xpRCew4ofahCM94q5hlh8ra1YSyFLYDtfqn0y6WXjtJGDXEF8D?=
 =?Windows-1252?Q?sOYpGGbfK3En7oiAAgu7HYDKjDHDFtu2S7F7aBM4PM1au8fGX80eY9pY?=
 =?Windows-1252?Q?7nsiB0/X97D11TObnQrXOmwNxHvK2EqWD/HglSo3SmFiCx8IR2jqeJnu?=
 =?Windows-1252?Q?MBpNuh9d2tnsb9QkcGihKlbjNE4mzUGBo/VGwZk3s8o7bfB/TQ5G+UU0?=
 =?Windows-1252?Q?qItntKyaP57hQPqiyuBcuWb24ZGzA4m+ZIs8oK1ATve318ANcGaqTbmJ?=
 =?Windows-1252?Q?OAaKB06wLuiAI86UhZZVFzoEy2SwXC1wyvqfzdRXeWT+T+4UCU67fJYy?=
 =?Windows-1252?Q?TDizllRURoeyhWPmlEl/UhOKgESRlWqacz7IqPBE4lrV3Ia1s29B+iUM?=
 =?Windows-1252?Q?b/USiwpBv9eg4xHo7sX73C3PEBaOBf+XUU+aBMaCBRPiDjLjigrOGk4w?=
 =?Windows-1252?Q?ysjiWEtwRewMw/DjOyyOkabqO2MwtkHlI8Wx2j/QUIbxa61dHSk2YZWu?=
 =?Windows-1252?Q?lcF4IVal7AxhZltSnVJauswF67droY/dmnXQr1sNfBKmGGwysChoeUTV?=
 =?Windows-1252?Q?BZD8bvcjbMZBipgls+zeC43dMogEyHA4B1fb/RwxqYqxVQU1+wRMz6/P?=
 =?Windows-1252?Q?th6UJ+8VkWtKrcezNz8B5r6b9t+/8ZeethTwMgvRPBJo6fMtScPnpm0N?=
 =?Windows-1252?Q?O4Kog28V66wIlAfRGPNtUsxvognOjLnxyn0lLNle9CxeqKccQDDYyxEi?=
 =?Windows-1252?Q?r7lNo0F/e2VQJQnE3Wpkn/tMTN2qsYvGiLnBHn3Y4/J7K7bEWJxZNhw3?=
 =?Windows-1252?Q?apaMhal4V24LRJERU6abYxs363UzhduHBZaqXPtOSUG+GjTh/NJmQeJx?=
 =?Windows-1252?Q?3FfZU+438gpwLzFetNpWK57dOUyAZnC3KxUvPV7OOAFmql5OKTH4mzVs?=
 =?Windows-1252?Q?IGcp0A2NtLlKFU7PtDg11Ie1dQzMcOjjmZNhrYNKdXA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY1PR0701MB1222;6:DT80TVq8pGYQkS6XvgiOkkBm0OuT2ig4IWDQ?=
 =?Windows-1252?Q?ng8wjdRzVq5CKinZByPEyagnAX8Wb18TcZ9dcaqCF7ngRWxdtf2ydj+T?=
 =?Windows-1252?Q?AigASbS81l/R9s9gR9xyuDNlGxugHixAHgzf2uQWcIZepwMGzMcnY0Jw?=
 =?Windows-1252?Q?vD2LkAUoYsJJ61GbOhrJ5QoxPhR4t1Yjv+YQ0TOAQdkph1jPRP3r/B2T?=
 =?Windows-1252?Q?6IIn8nPpcJmBRjfgHjMCAYepitw0Yqz3DtAgFiCfDfgFu/bwKSQgNX2Z?=
 =?Windows-1252?Q?6IJpNsjDMVw5Tlh33NGqlE3f7QnO2XVfynZiDNAaqMkFzZVKhzktfEej?=
 =?Windows-1252?Q?NMw5ZonNPOFZZy66kI7LeSo3R1DWZEMGSogJJAUpNYpxPzUJdmxXMMdh?=
 =?Windows-1252?Q?BUwQHPe300gcvz9dGouD3S2vr1nUwDgGKiDmdoyrjjpBDgXIc9GzcvNV?=
 =?Windows-1252?Q?REcUUuWYGnxdEEHR3zwURhCmkpteNCnFviNY+iohvu0CXa4JiLvPh+EU?=
 =?Windows-1252?Q?7kPl6uqMfVzLJ1XI2gCeYssaBLzA4sXLPJrKb2NWELcuZ8F5zX/sT8ot?=
 =?Windows-1252?Q?b++vob9Zxy+gtLegmzzKb+IzDbcEntYmOJyddhGcXLf9BvfvQBbI5vUH?=
 =?Windows-1252?Q?al5EGN/L5dW9EUUNP6j895tgBS5AEfCbF+0zTUybjoty4ey3BtTxgiWu?=
 =?Windows-1252?Q?mm887zba6Sc0Ybvy7QmWKFZluQwpiHZlbJqKxspEn56e5JSC6GaTFqP8?=
 =?Windows-1252?Q?90kyer4iAhMtIwrH+Xn0o8+pQhZouxka6dwvf9aQYAAQiS5rI23S/VEa?=
 =?Windows-1252?Q?oTHYdzU918LQfeHwGz9VRbX1l0cgQnmAQbJxUyZP8IGjB7IrBcHE8kEX?=
 =?Windows-1252?Q?C0pGLBhWkUDr9KS5yPLhy2TtXZ6CdefHD55FJ7MgJnfXs0r6NgRfGNfi?=
 =?Windows-1252?Q?lAI4olO9uC22gGI03D07Id8JnfC2KTnbWA2J7E11wUUUbyHkTOSWp5dP?=
 =?Windows-1252?Q?5wF7kCUkpJ4tgbAdAUma1J9mWRXZiw9ffrUnc6YEUHEW5Yjy3NGP0gB0?=
 =?Windows-1252?Q?1Mjt6BtQNGsWrlY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1222;5:CP71qIFcTBkzH+CgBjsWg2GhoZw7AT8veBMgEjGaNTP351gEaPET4Y1UMayBjyWkMUQsgDuz4SgKi0du9op58azYPSC73py6sklbYWxb5qfTt6NolY0vlnQ8YixujoWCo/YmC2+6pK8rH/SaHDOOMO9JK/cQgxg0Sg2eteCtfSEOzlN8mgiGO7dB4wMiuchyC27Gaa8BVCacbh//t46JpSqWzP7x7zcHKRzy8fVjBGybbML3cPiOalg9w0H9Pzm8H8A9JxmCH8NIw0stEWd2ebP6mOToOobrBh5GVpzLB2VD5kgifA25H/9QaVoVQnXfAZmVCP7AB/4vOgYr3Y+FfZT43HhrVH8SKK3ypTYv0v4tlOOBMqi00L16K2Lz/R3qjpjalLZPbHdpM8DI7Wx74Ce4VFQzliAm6T3JLRNzUMr4STPfYYzxgQyga+Ga4X/S3Vz0O40Db1eUJKEysPoU01DoJV+oJ/mzTa4TeaBOHmVaVerJN5sMR9FxNcNoiyGb;24:12C/go0yttj7wbnpukCSOaY+XCm8TFM5hQE5uGguau7gxxsWf+hqNvwL1qVn8Fo+OK5AL9S/8oNvr3W6dz6Xcv+SWSUy1GmZouv2AWX7fHI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1222;7:IpU+CjT4V567fQdX3b7GTY+zFh/OSb9HfFnZVRDudMAxAXSjJfUqUYc8l5vZSQ/+RZETpa1z5pRFS4tXCZYRxIX8cv2Qf8gOEC3f/PJwcGKfsFWoI0nZp6LMx5bl7BSWuT36unmfn3bABlMS3Xq+i6DazFsKsXa9SoGjhvu3BHpjAtLM/tugGCK8LfC+8KoQu0V3AinjIzSjBGPrGpXLYrHfHpq70uYWgjxxD/Ng5uMuTqL1udHkxYaBuRmNQpUyah3bdwOlrWEyDKf4deXIo/vzQEY4n1lXEivm/E6yAVFcXZvwh2qvBQDw2yIGkeOUawnff2LOYdFKHumJNisAVzXuRwu/xzgErftaFj+YolvEeNFaqIciFVeC++dAWVHyoTKpgymeCiuXpXSRIPcezinPt4HRyVyqf4IzGWUWsYoO9iwVYa6GBEzxPRAtCm4mRO0/uMqhXHTdcIKtMeYhjp8H/m5o08nG60EmSU0mxbr52iN4i5FtV4uhIpuTzlX+g59pS0JjtFg15JHcnMfEiMhQz3vhUbiduwjLg0tJf7fAJKyxG0pvLCkGSrw+x85shT+2wchuLJxgZhny8KO1If4sSdDhF/nhNmPwtttLC+EV+Ei/d+JTNz8iX1hYIJPs3+bwwaygEHfeEQ84wC4me3XUfLwoXOQvpnch6w5kbbHlkpcJuSFYykcRcUeNojQ+R6meYG88YpWhjTDtC99cT+RbR79EKUv4kU6qbamV6ObD+TlBNzeM1sBnBCjb4QKak1ExCBa9p0HcgyCi04o/zYbZKGoWEpu+aIDsPS64fhA=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2017 14:45:24.1648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1222
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 06/29/2017 02:41 PM, kbuild test robot wrote:
> tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next head:   152e63e374cdc0dc7a321d523dd2930de0acdabf commit: 6b1e76297c4ad4b906fdf054460e4e56914f6e34 [36/72] MIPS: cmpxchg: Unify R10000_LLSC_WAR & non-R10000_LLSC_WAR cases config: mips-allyesconfig (attached as .config) compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705 reproduce: wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross chmod +x ~/bin/make.cross git checkout 6b1e76297c4ad4b906fdf054460e4e56914f6e34 # save the attached .config to linux build tree make.cross ARCH=mips
> 
OMG...please remove this tree from the build robot. It is my
personal tree and of no value to anyone. Cheers.
